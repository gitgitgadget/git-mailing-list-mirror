From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 2 Sep 2008 02:25:14 +0300
Message-ID: <94a0d4530809011625n772fdc58h3ce1c04e79fb116f@mail.gmail.com>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
	 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
	 <7v63pftqmk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:26:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIms-0003A5-5L
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYIAXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYIAXZS
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:25:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:3992 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbYIAXZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:25:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1996274rvb.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IBaj20O32GZmvQfPYP5BRbTcORtxal10ZpB2cp4pTFM=;
        b=k2ZUe9kyuf+4sy8ToNzsBL+NYfGhr3NTtdzdmb2+bZMUiDH5yj0KnGCeMiCKgER2z2
         2nvVTib36BhI7I/W63oyBJSkjoMAziLKzHGwW2Lkwk3jYvbcahgZqOVN0gm7JwcSFC6b
         bkkWstOLOBI+AJ4chh4qzlOP08+Jso919ctVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Loi52vCgizK5Si3SCjbSLiKat4f2JQ9wl+OhwmBJnAOSM1BWPmxWfw+87zZJMqdq/O
         ZJT/p0WjussFjkBBrx6A6YQIbSCeNHQ2eRw3lgTA5kd/sMyUEXmmlzpf947850WTvAOD
         wnh7ffD84Pl7gAeMuMjwqHy4OtheLF9EkwNFc=
Received: by 10.141.116.16 with SMTP id t16mr3731768rvm.280.1220311514250;
        Mon, 01 Sep 2008 16:25:14 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 1 Sep 2008 16:25:14 -0700 (PDT)
In-Reply-To: <7v63pftqmk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94629>

On Tue, Sep 2, 2008 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is useful for SCMs that don't have proper changesets in each
>> revision (monotone).
>
> I am still not convinced this is a proper workaround for the issue.  Why
> shouldn't the feeder of fast-import be able to do this?

If I could get a list of the files that changed on each revision from
monotone I would, but that's not possible (I've asked in their mailing
list). Apparently there's a way to feed the right data, but it's
complicated.

Just to give you a sense. Right now I'm simply parsing all the changes
in the revision and converting them to fast-import's format. I don't
need to check if the revision has multiple parents, or not.

Now, in order to feed the right data I would have to find the
old_revision markers, use a hash table to store the file changes per
revision, after the parsing find out if there's more than one parent.
If there's more than one parent then find out the duplicate actions
that are in all the parents and store them in a new list of actions.
If there's only one parent then simply use the list of actions of that
parent.

I can spend some time trying to get that working, but a) this
workaround is much simpler, and b) I'm thinking on writing the final
converter in C. I really don't want to mess with all this complexity
unless I absolutely must.

If you are interested in the current code: http://pastie.org/264209.

>> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
>> ...
>
> Also what happened to the missing warning() for 'D'elete codepath?

I'm not interested in it.

I added it because I thought it was missing. Since apparently it's
more important to don't alter the old behaviour I prefer to scratch my
own itch and focus on what I need.

-- 
Felipe Contreras
