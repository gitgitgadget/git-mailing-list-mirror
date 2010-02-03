From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 3 Feb 2010 15:40:02 -0500
Message-ID: <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> 
	<ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home> 
	<ron1-34F9C6.12273203022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncm1X-0000ZO-5d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821Ab0BCUkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 15:40:25 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:49110 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932814Ab0BCUkX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 15:40:23 -0500
Received: by ywh36 with SMTP id 36so1681731ywh.15
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=okxxB6VEPyMOZ+zpfo/NfhK0A1WWu2erErvOqZ4LxvU=;
        b=srY2s9Jw0Q6qvOKN+4eURseXaWHhnZeuM/yz60w9HYAEXLbhuKKzY2dU8GU8oKW4x2
         rr0qgvUB1rSYoYyC9+8fWP6Uxo6JNSqR+zktSzDJrKBIn0HU004KS3frBvhJLNxPlwE4
         HuvFlljwLVUUmAXnFJ2Jo7i9HKlZltrGO1mg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UBIEv3jvtDDjzFMiCYZd3XHHuT4mwEL93jHF1P7w9pTuUUP94v4R9AYsjIEactf04r
         NJq74ykrLKWHxJbyCBKScd8PQM3EN40LnDAXe64y/iZWKIPAXZ5bPoq2pdAIMERP5BT0
         2hSAcyKHnK8c7Dt54ojgbxQ1NeGLlSlTnc8n8=
Received: by 10.150.176.3 with SMTP id y3mr541418ybe.346.1265229622080; Wed, 
	03 Feb 2010 12:40:22 -0800 (PST)
In-Reply-To: <ron1-34F9C6.12273203022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138891>

On Wed, Feb 3, 2010 at 3:27 PM, Ron Garret <ron1@flownet.com> wrote:
> So I think I'm beginning to understand how this works, but that leads=
 me
> to another question: it seems to me that there are potential screw ca=
ses
> for this purely content-based system of tracking files. =A0For exampl=
e,
> suppose I have a directory full of sample config files, all of which =
are
> similar to each other. =A0Will that cause diffcore to get confused?

Cases like that are always confusing, even to humans.  Person A
renames X to Y, but at the same time creates Z which is almost
identical.  Person B patches X, then merges in person A's changes.

What do you expect to happen?  Should Y be changed, because that's the
file X was moved from?  Or should we change Z, because it's almost the
same content anyway?  Or maybe we should change both, since a change
to the old X is probably intended to affect the copied *content* that
ended up in both Y and Z?

Simply storing whether person A has renamed vs. copied vs. added a
file makes the answer to the "what do you expect to happen" question
more obvious, but fails to answer the "what *should* happen" question.
 Thus it's more of a distraction than a feature.  It took a while for
me to accept this, but once I did, I realized that git's behaviour has
still never caused me a problem in real life, despite repeated file
renames and complicated merges.

In contrast, svn's explicit rename tracking has shot me in the foot
numerous times.  (svn remembers when I delete file X and then
subsequently re-add it with the same content.  So if I merge in
someone's change to the *old* file X, it barfs because omg omg that's
a totally different file X and it can't possibly figure out what to
do.  Gee, thanks.  It's also hopelessly incompetent at handling
"renames" in which a newbie developer didn't know to use svn mv, but
instead used svn rm, mv, and svn add.)

Have fun,

Avery
