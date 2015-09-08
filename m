From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Tue, 08 Sep 2015 10:32:12 -0700
Message-ID: <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
	<CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 19:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZMkl-0003RR-O3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 19:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbbIHRcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 13:32:15 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34618 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbIHRcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 13:32:14 -0400
Received: by padhy16 with SMTP id hy16so127431225pad.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=pJxkcdqA2YAEP/12RvAL+glddtWsfLAVQH8pQP9BduM=;
        b=uCXnxVIfOlG007IbqQNyMzSsv8g/pkyhUH96J34YHZBPoL8tPlor0ryaETJcx5u6aD
         wSCKDJBTzbPfmojWsVsdcYsIMJEzQ1pFE2TIP4rvtjCx4h9/O0XX9RaNW3+96sVOI26A
         ErfrFZ3V1fjmVWjgqCO3t6/GEryXTlMuA+C/Emnn925798e5QHg6ScURw74Q6suTay65
         AKohd8QHiIlXLAPZ3tvvSc0RLkgeaBPWjPcmxxb4Itne8zZJtstBvg5YyjO6R4VVwIFf
         GGNxacNT9bHXL+bmv1H5Om78eQI+12jnNK3Dj6DQ8apfgeEPxKIV3ShUDmmAoePKuaoL
         jU/g==
X-Received: by 10.66.144.40 with SMTP id sj8mr11538561pab.72.1441733534005;
        Tue, 08 Sep 2015 10:32:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id h4sm4086471pdd.91.2015.09.08.10.32.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 10:32:13 -0700 (PDT)
In-Reply-To: <CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 7 Sep 2015 16:54:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277507>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@primer=
anks.net> wrote:
>...
>>  # Rewrite the commits
>> +report_progress ()
>> +{
>> +if test -n "$progress"
>> +then
>
> Indent code within the function...

Also git_filter_branch__commit_count is now used only inside this
function, so it is easier to follow to increment it here.

I suspect that the variable has this unwieldy name for historic
reasons, perhaps an attempt to avoid name clashes with the end user
script, but it has many variables (e.g. $commits, $ref, etc.) that
are way too generic and that I can see no attempt of name clash
avoidance, so renaming it to $total_commits or something _might_
make some sense.

> ...
>> +printf "\rRewrite $commit ($git_filter_branch__commit_count/$commit=
s)$progress"
>
> The "\r" causes this status line to be overwritten each time through,
> and since the processed commit count always increases, we know that
> the original (without ETA) will never leave junk at the end of the
> line. However, with estimated seconds also being displayed, does this
> still hold?

Good point.

Perhaps like this squashed in?

 git-filter-branch.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 565144a..30ef513 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -277,27 +277,28 @@ test $commits -eq 0 && die "Found nothing to rewr=
ite"
 # Rewrite the commits
 report_progress ()
 {
-if test -n "$progress"
-then
-	if test $git_filter_branch__commit_count -gt $next_sample_at
+	git_filter_branch__commit_count=3D$(($git_filter_branch__commit_count=
+1))
+
+	if test -n "$progress"
 	then
-		now_timestamp=3D$(date +%s)
-		elapsed_seconds=3D$(($now_timestamp - $start_timestamp))
-		remaining_second=3D$(( ($commits - $git_filter_branch__commit_count)=
 * $elapsed_seconds / $git_filter_branch__commit_count ))
-		if test $elapsed_seconds -gt 0
+		if test "$git_filter_branch__commit_count" -gt "$next_sample_at"
 		then
-			next_sample_at=3D$(( ($elapsed_seconds + 1) * $git_filter_branch__c=
ommit_count / $elapsed_seconds ))
-		else
-			next_sample_at=3D$(($next_sample_at + 1))
+			now_timestamp=3D$(date "+%s")
+			elapsed_seconds=3D$(($now_timestamp - $start_timestamp))
+				remaining_second=3D$(( ($commits - $git_filter_branch__commit_coun=
t) * $elapsed_seconds / $git_filter_branch__commit_count ))
+			if test $elapsed_seconds -gt 0
+			then
+				next_sample_at=3D$(( ($elapsed_seconds + 1) * $git_filter_branch__=
commit_count / $elapsed_seconds ))
+			else
+				next_sample_at=3D$(($next_sample_at + 1))
+			fi
+			progress=3D" ($elapsed_seconds seconds passed, remaining $remaining=
_second predicted)"
 		fi
-		progress=3D" ($elapsed_seconds seconds passed, remaining $remaining_=
second predicted)"
 	fi
-fi
-printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)$=
progress"
+	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)=
$progress            "
 }
=20
 git_filter_branch__commit_count=3D0
-
 progress=3D start_timestamp=3D
 if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
 then
@@ -306,9 +307,8 @@ then
 		start_timestamp=3D$(date '+%s')
 fi
=20
-while read commit parents; do
-	git_filter_branch__commit_count=3D$(($git_filter_branch__commit_count=
+1))
-
+while read commit parents
+do
 	report_progress
=20
 	case "$filter_subdir" in
