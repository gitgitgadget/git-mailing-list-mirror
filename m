From: Joe Ratterman <jratt0@gmail.com>
Subject: Re: Background processes in post-receive hook
Date: Sat, 2 Apr 2011 23:59:59 -0500
Message-ID: <AANLkTim3Eu+rHc3_7_PWsALK3QwuzyX2Anbn8o6aCbAE@mail.gmail.com>
References: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
	<BANLkTin4-fMhi_5H1oZ+gPB99stj5GRjVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Pickens <jepicken@gmail.com>, Git list <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 07:00:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6FQM-0003J2-QB
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 07:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab1DCFAB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 01:00:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47706 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1DCFAA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 01:00:00 -0400
Received: by iyb14 with SMTP id 14so4876346iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vVxeUApFQY0pIJ3D4MDnBZV2XrRKGO8FwoJ8J1Rr+vg=;
        b=NUn5hY/rlgAHd/MzLt6DKuwEjR72S/ovf+KXk2AC62HXeAZQ8pqNCaZ/HcncApH6dQ
         fPlimmJvCvGSXaN+TO/KJHk39mOHLysbGzn6a5GKBl3uY1dX3gFVXeGGxIsY8JdX94kY
         oon+sfGDrIlxzW+JF/Jyix6+GYVOehF+iywKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dUXQHS3q52H9rkDxDRCXQmeTKiiQ4FVKGJiiydxzdQ5XENpq1qa3K+5Faj6GU29erh
         Qoiqwu/JjFetL/i2F5UYBBOSqGY7bxNjg5/CsbaOQHg+4wcK4wXPXOGg2v8BaDUw4Ape
         iXbjtnsATdixKUygwRbcJBfOch/nP5XfmKKjw=
Received: by 10.43.64.82 with SMTP id xh18mr6546579icb.65.1301806799768; Sat,
 02 Apr 2011 21:59:59 -0700 (PDT)
Received: by 10.43.56.7 with HTTP; Sat, 2 Apr 2011 21:59:59 -0700 (PDT)
In-Reply-To: <BANLkTin4-fMhi_5H1oZ+gPB99stj5GRjVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170676>

On Sat, Apr 2, 2011 at 10:22 PM, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:
> interestingly, the double fork trick doesn't work either...
>
> =C2=A0( ( long-running-command & ) )

I think that is because the hook is still reading from the command's
stdout.  If you close stdout/stderr, I would expect it to work.  For
example, the "sort" command below cannot exit until all sub-programs
have finished feeding it data.  You can see that despite the levels of
forking involved, the stdout of perl and the stdin of sort are the
same.

$ ( ( perl -e 'sleep 60; print "THERE\n";' & ) ) | sort > /tmp/out &
[1] 4033
$ ps h
=2E..
 4033 pts/10   S      0:00 sort
 4035 pts/10   S      0:00 perl -e sleep 60; print "THERE\n";
=2E..
$ ll /proc/{4035,4033}/fd
/proc/4033/fd:
total 0
lr-x------ 1 jratt bgq 64 Apr  2 23:49 0 -> pipe:[55227211]
l-wx------ 1 jratt bgq 64 Apr  2 23:49 1 -> /tmp/out
lrwx------ 1 jratt bgq 64 Apr  2 23:49 2 -> /dev/pts/10

/proc/4035/fd:
total 0
lr-x------ 1 jratt bgq 64 Apr  2 23:49 0 -> /dev/null
l-wx------ 1 jratt bgq 64 Apr  2 23:49 1 -> pipe:[55227211]
lrwx------ 1 jratt bgq 64 Apr  2 23:49 2 -> /dev/pts/10
$ cat /tmp/out
$ fg
( ( perl -e 'sleep 60; print "THERE\n";' & ) ) | sort > /tmp/out
$ cat /tmp/out
THERE



However, this version exits before the shell returns to the prompt
(and the output is lost).

$ ( ( perl -e 'close STDOUT; close STDERR;sleep 60; print "THERE\n";'
& ) ) | sort > /tmp/out &
[1] 4097
[1]+  Done                    ( ( perl -e 'close STDOUT; close
STDERR;sleep 60; print "THERE\n";' & ) ) | sort > /tmp/out
$



Joe
