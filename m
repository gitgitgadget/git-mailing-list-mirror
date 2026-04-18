Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076520468E
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776537379; cv=none; b=WMFM36h3lOY5yRjE9dxfWupojZFtG7VjMWMflfMNQbGJD8Qsb/AyqWjAFJa/C2lh35fjhaQ8bCWqTYCIfdK+kOMIWL/X0zc73HKqAwfA7hhSbAQjONQTwb7LdJ1+aQrltdby1BuWLFIfLwNayahv07k0BXdgJzbi0ql9A0ptiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776537379; c=relaxed/simple;
	bh=dHX1dTgqzgP8+dC2Gm88IIHP6moh9ZHDtHSbWtaybd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=S3blgaOOlkd4KizYSDbnki4Xn7jK42iX8AHYgxUvAQZJESoK+ogHkFCh/x+V0zm2Z7BjX7WmbvEyqidxXYyGQADmDs0mJ8SLMFFSzNN7vANVj6dCa6GGVhtLrqkiIrfG69dhRqgHp2sP0MFkdtifCFlI5BbmPIpFVsV+V9IVHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fyfPy1x7Hz7QV0Z
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 19:49:10 +0200 (CEST)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fyfPm41HKzRmwt;
	Sat, 18 Apr 2026 19:49:00 +0200 (CEST)
Message-ID: <ee2599a5-13b6-469a-a284-4a5d26b2c721@kdbg.org>
Date: Sat, 18 Apr 2026 19:48:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitk: race condition when changing view
To: Michael Warmuth-Uhl <michael.warmuth-uhl@suljee.de>
References: <20260416233639.32e5b481@rosa.suljee.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20260416233639.32e5b481@rosa.suljee.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.04.26 um 23:36 schrieb Michael Warmuth-Uhl:
> when displaying a bigger commit and then changing the view, gitk reports 
> 
>         can't read "treediffs(b107a60c5bed3002ecef93b4405a44d809776e6f)": no such variable
>         can't read "treediffs(b107a60c5bed3002ecef93b4405a44d809776e6f)": no such variable
>             while executing
>         "lsearch -exact $treediffs($ids) $fname"
>             (procedure "makediffhdr" line 7)
>             invoked from within
>         "makediffhdr $fname $ids"
>             (procedure "parseblobdiffline" line 56)
>             invoked from within
>         "parseblobdiffline $ids $line"
>             (procedure "getblobdiffline" line 16)
>             invoked from within
>         "getblobdiffline file6 b107a60c5bed3002ecef93b4405a44d809776e6f"
>             ("eval" body line 1)
>             invoked from within
>         "eval $script"
>             (procedure "dorunq" line 11)
>             invoked from within
>         "dorunq"
>             ("after" script)
> 
> It is reproducible with:
> 
>         TCDIR=/tmp/testcase
>         N=512
> 
>         rm -rf $TCDIR
>         git init $TCDIR
>         for i in `seq $N` ; do 
>             dd if=/dev/random status=none bs=1024 count=16 | uuencode "" > $TCDIR/foo_$i 
>         done
>         git -C $TCDIR add . 
>         git -C $TCDIR commit -m "commit" 
> 
>         cd $TCDIR
>         gitk --all
> 
> followed by an immediate change to "All Files" in gitk menu "View".
> 
> That happens because proc showview (and some others) clear treediffs which is 
> still needed by tasks pending in runq.
> 
> The patch below makes showview wait until runq is empty which is slow (waits for 
> useless operations) and feels wrong. I have no idea how to cleanly flush runq 
> instead.
> 
> The same issue has been mentioned here before: 
> 	https://stackoverflow.com/questions/17977996/gitk-cant-read-treediffs-error
> 
> Michael

Thank you for the report, the reproducer, and for digging into the issue.

Waiting for the process to complete is certainly not the most desirable
way to handle the situation. I've attempted to clear the run queue with
the patch below, but the reproduction recipe still triggers an error
'can't unset "currunq": no such variable', the reason being that proc
dorunq is entered recursively via one of the queued scripts, and I
haven't found why that is the case.

I'll look into this further as time permits, but don't hold your breath.

-- Hannes

diff --git a/gitk b/gitk
index dc042a5..51d9fe5 100755
--- a/gitk
+++ b/gitk
@@ -4693,6 +4693,17 @@ proc showview {n} {
     }
     unselectline
     normalline
+    global runq
+    foreach curq $runq {
+        set fd [lindex $curq 0]
+        if {$fd ne {}} {
+            catch {close $fd}
+        } else {
+            set script [lindex $curq 1]
+            unset isonrunq($script)
+        }
+    }
+    set runq {}
     unset -nocomplain treediffs
     clear_display
     if {[info exists hlview] && $hlview == $n} {

