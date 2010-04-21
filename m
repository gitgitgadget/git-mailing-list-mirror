From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH] Make --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 17:02:24 +0800
Message-ID: <i2r41f08ee11004210202r642aa25dy32b06c33ed98ba4c@mail.gmail.com>
References: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com>
	 <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 11:02:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4VpJ-000142-6I
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 11:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab0DUJC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 05:02:27 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51640 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab0DUJCZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 05:02:25 -0400
Received: by qyk9 with SMTP id 9so8945435qyk.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xRoLkaNtS/dHiNj4T9xz+3qbrqFYERVEZQy7dxTeYog=;
        b=Kj2Ss4eg9UHnEGcEglyB2f5pKE676o8dtsEbDdwOqLtnxfecQohFnnMG4N/7GK467A
         wddmanJZ480ikmZEWM5EkfO2zsetGdbtB+gygYweqrFaJlL3Tk+Iu1fOtKpLIgQc0pdA
         N5qWp6p+uWgY3h0ZXZaohu93lRubNelu+NNdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JbgkmAi9/jwGdr8BTfHEdTSnu5FQv9XAFwe5f88n/H6t2icMvRCzh/Sg/DMF9Abuet
         sIZkTHlzQO4/aCSkJ4NnIXMOJcye+1qD+Qd6nT4UJW7LGyMGCL22SX5HveS6Y7jkSeKt
         F+RXEosqhi00Gw44kCFL8Sq1oUdOb8vI7H7hY=
Received: by 10.229.98.196 with HTTP; Wed, 21 Apr 2010 02:02:24 -0700 (PDT)
In-Reply-To: <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
Received: by 10.229.217.206 with SMTP id hn14mr4715099qcb.70.1271840544848; 
	Wed, 21 Apr 2010 02:02:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145421>

On Wed, Apr 21, 2010 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Because the "--follow" hack was done primarily as a "checkbox" item, =
and
> also because it is not an option for the "diff" family (it is an opti=
on
> for the "log" family), I would personally think that it is actually a=
 bug
> that "git diff" accepts "--follow" and pretends as if it is doing use=
ful
> work, but does so only some of the time.
>
> =A0 =A0$ git diff --follow --name-status maint master -- builtin/log.=
c
> =A0 =A0R089 =A0 =A0 =A0 =A0builtin-log.c =A0 builtin/log.c
> =A0 =A0$ git diff --follow --name-status -R maint master -- builtin/l=
og.c
> =A0 =A0D =A0 builtin/log.c
> =A0 =A0$ git diff --follow --name-status master maint -- builtin/log.=
c
> =A0 =A0D =A0 builtin/log.c

I am really wondering, when -R is used, how the file rename/copy
should defined? Now, I can make -R works with --follow, and it produce
something like:

byang@byang-laptop:~/git/git$ ./git diff --follow --name-status maint
master -- builtin/log.c
R089    builtin-log.c   builtin/log.c
byang@byang-laptop:~/git/git$ ./git diff --follow --name-status -R
maint master -- builtin/log.c
R089    builtin/log.c   builtin-log.c
byang@byang-laptop:~/git/git$ ./git diff --follow --name-status
master maint -- builtin/log.c
D       builtin/log.c
byang@byang-laptop:~/git/git$ ./git diff --follow --name-status -R
master maint -- builtin/log.c
A       builtin/log.c


The problem is whether it make sense to say 'builtin/log.c renamed to
builtin-log.c' when -R is given?

Regards!
Bo
