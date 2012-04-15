From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 13:12:12 +0200
Message-ID: <4F8AAD0C.4060207@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki> <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJNNr-0003BD-8y
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab2DOLMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:12:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41233 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab2DOLMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:12:19 -0400
Received: by wibhj6 with SMTP id hj6so7785387wib.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=JIMIdK7UtL6XE4S/NsS1qHSMwReey5ygP+nsP5ixOX8=;
        b=dxyGbkYSp2ORpG4N7cpRsTvV/l+/v8+n74zhGqFk0w0x7NOq2XQmLDyZiX6ZDfmwpC
         Ynvrm+pvyLlAFaCwAKXsZ6RnZc297zU6CmySch9IeUcj79NLiqfOKiGRN70BtsSOJz1i
         dkiT96nInkR4laKTjRoH7aFe9kP7FV9wLvei41Oe1SC5rlmEazxEXogA/qb3tbsJyn4t
         zBFw2n+W68heOLWBxVJOhUUHlv0TQUeyKBbYr3lfv9YZSYk6l/BUb0lG7GuxnfparA8d
         SCKRHp2eWbdmNkjFo2qINhyUMv/TeIERNEof/h3pmzmE93MqDtL894qrVZO79On0uHpH
         uN2Q==
Received: by 10.180.20.47 with SMTP id k15mr10038201wie.19.1334488338105;
        Sun, 15 Apr 2012 04:12:18 -0700 (PDT)
Received: from [87.8.92.183] (host183-92-dynamic.8-87-r.retail.telecomitalia.it. [87.8.92.183])
        by mx.google.com with ESMTPS id w10sm18504059wiy.3.2012.04.15.04.12.15
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 04:12:16 -0700 (PDT)
In-Reply-To: <20120415011118.GA4123@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195559>

On 04/15/2012 03:11 AM, Clemens Buchacher wrote:
> On Sun, Apr 15, 2012 at 02:00:22AM +0200, Stefano Lattarini wrote:
>>
>> Debug: Remote helper: -> export
>> Got command 'export' with args ''
>> Debug: Remote helper: Waiting...
> 
> Hmm. Looks like fast-import and fast-export are in a deadlock. It's
> probably time to let the experts take over. But if you want to indulge
> me further, you could try again with GIT_TRACE=1.  That should give you
> the arguments to use for the fast-export and fast-import commands right
> before it hangs. Then run ./t5800-remote-helpers.sh -i with the
> following change to make it abort right before git push:
> 
> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
> index 1c62001..c4855e9 100755
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -68,7 +68,8 @@ test_expect_success 'pushing to local repo' '
>         (cd localclone &&
>         echo content >>file &&
>         git commit -a -m three &&
> -       git push) &&
> +       false &&
> +       GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
>         compare_refs localclone HEAD server HEAD
>  '
>  
> 
As your later reply pointed out: yes, I had missed the remaining part of your
message :-(  Sorry for the confusion.  I'm going to reply to it now.

> You can manually now run fast-export using the arguments from the first
> run, for example in my case:
> 
>  cd trash\ directory.t5800-remote-helpers
>  (cd localclone; git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '--import-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master') |
> 
> That should output:
> 
> feature done
> blob
> mark :5
> data 24
> content
> content
> content
> 
> commit refs/heads/master
> mark :6
> author A U Thor <author@example.com> 1334451823 +0000
> committer C O Mitter <committer@example.com> 1334451823 +0000
> data 6
> three
> from :4
> M 100644 :5 file
> 
> done
> 
>
Nope, for me it fails with status '128' and with this error message:

  fatal: cannot read '.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks': No such file or directory

> Finally, you can manually pipe fast-export to fast-import, again using
> the arguments from the first run:
> 
>  cd trash\ directory.t5800-remote-helpers
>  (cd localclone; git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '--import-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master') |
>  (cd server; git fast-import '--quiet' '--export-marks=/home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks' '--import-marks=/home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks')
> 
This fails with the following message:

fatal: cannot read '.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks': No such file or directory
fatal: cannot read '/home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks': No such file or directory
fast-import: dumping crash report to .git/fast_import_crash_19819
error: Unable to write marks file /home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks: No such file or directory

> If the fast-export output is the same, and if the last command also
> hangs for you, then we can start debugging fast-import.
> 
> Clemens

Thanks,
  Stefano
