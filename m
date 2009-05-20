From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 12:58:05 +0800
Message-ID: <46dff0320905192158k340ece90xd88af53792056b67@mail.gmail.com>
References: <4A136C40.6020808@workspacewhiz.com>
	 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	 <20090520032139.GB10212@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 06:58:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6dsg-0003Tv-Fb
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 06:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbZETE6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 00:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZETE6H
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 00:58:07 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:57411 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZETE6F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 00:58:05 -0400
Received: by gxk10 with SMTP id 10so456898gxk.13
        for <git@vger.kernel.org>; Tue, 19 May 2009 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i+NJFUzsW5TYAgHqhOT48eciNwQPXtpnybtWvtM5nqo=;
        b=q98q0bWSUfZA5AK/SNc6RnaGYxsZYuefvCvrZSK2ApEczHadYvfLdfv/Uan//PNOCC
         /K6T7X5OVGf/iV5HdpR3HjP2oV4qfo/zcXY28uoF2lr2vnkDde1inncaCXpzEgBXYDHn
         iqGo4mveRcyIKE/W8mXZgr8zju5Ar8p2Sekqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IkdtksX9srExHTZkj2Gc3LdOjiXK0YRA2oQMlJEuZNzg1XJYmFOQF7M183Wa4JCpYU
         oBZr+jt2hZOaIdiigCKkshWM236hq9Z0T5KN5U33ZucByARly/h0B2aZf1Px2eZ4AUJU
         JxbU+GUiKQAlVXD48b4brt4QJ2rhFwDt00/1c=
Received: by 10.90.101.17 with SMTP id y17mr697857agb.107.1242795485868; Tue, 
	19 May 2009 21:58:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119583>

On Wed, May 20, 2009 at 11:35 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 19 May 2009, Jeff King wrote:
>
>> On Tue, May 19, 2009 at 11:10:14PM -0400, Nicolas Pitre wrote:
>>
>> > > So here's the idea: What if Git, upon a revert change (or git re=
set --hard
>> > > HEAD), "committed" the changes to be reverted and then did the r=
evert with a
>> > > 'git reset --hard HEAD^'? =C2=A0The reverted files would be disc=
onnected from a
>> > > branch, but they would be available in the reflog to retrieve.
>> >
>> > I think there is indeed some value in having a commit of the work
>> > directory dirty state automatically made before this state is disc=
arded,
>>
>> Related to this, I have wondered if it might be useful to have an "i=
ndex
>> reflog". If I do something like this:
>>
>> =C2=A0 $ git add foo
>> =C2=A0 $ hack hack hack
>> =C2=A0 $ git add foo
>>
>> Then the first added state of "foo" is available in the object datab=
ase,
>> but it is not connected to the name "foo" in any way, which makes it
>> much harder to find. If we had a reflog pointing to trees representi=
ng
>> the index state after each change, then it would be simple (you coul=
d
>> look at "INDEX@{1}:foo" or similar).
>>
>> I don't know if the performance is an issue. We are writing an extra
>> tree every time we touch the index, but in many cases you are alread=
y
>> writing a blob.
>
> Well... Actually I think having a reflog dedicated to discarded state
> would probably be a better idea. And...
>

Agree. The issues about losing changes due to wrong operation have
raised many times in the list, such as

git add .
git reset --hard

With reflog for discarded changes,  this can be easily recovered.
