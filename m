From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/16] line-range: teach -L^/RE/ to search from start of file
Date: Tue,  6 Aug 2013 09:59:45 -0400
Message-ID: <1375797589-65308-13-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hot-0003fH-TG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab3HFOAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:55 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38295 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3HFOAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:54 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so603201obc.35
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVJ/ZD7Edm5S9+j9xLMw2WlpxMymBMPiTQPyMehcfec=;
        b=kRE9SVzwLcttZZb3cTq7+FrwH8GbLNRLWprlZJSPvIdwZ3a+aw3JsP3WCYwOE5OX+a
         TQw8tiHEYWPexKSJfpFIhX55AlMFD3ju90biDT9XIkr9/z+IKVV+Ny2h7+RP5Vf6lJn5
         Aj/tr/17fkFBS+7DUK0bM3GJyikJ6bD8HUNabzN+zwdCGMZaqcg9U0TL6yZoQyFV746z
         KSUw614IHpQsIfAApQNyySOifAoJpEonTuXQlMbkaBCGzZtOrGudmY/7myhn15gN4JVw
         mlTP4VR4bpQvffQC4WfSDOW/1O3/oPokUxv1uQwBwBJHpH/tXgAhT1oF+o2V+rO7XA03
         TmAA==
X-Received: by 10.182.227.136 with SMTP id sa8mr1139830obc.39.1375797650352;
        Tue, 06 Aug 2013 07:00:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231746>

The -L/RE/ option of blame/log searches from the end of the previous -L
range, if any. Add new notation -L^/RE/ to override this behavior and
search from start of file.

The new ^/RE/ syntax is valid only as the <start> argument of
-L<start>,<end>. The <end> argument, as usual, is relative to <start>.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/line-range-format.txt |  1 +
 line-range.c                        | 10 ++++++++--
 t/annotate-tests.sh                 | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 42d74f7..cf84417 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -11,6 +11,7 @@ absolute line number (lines count from 1).
 This form will use the first line matching the given
 POSIX regex. If <start> is a regex, it will search from the end of
 the previous `-L` range, if any, otherwise from the start of file.
+If <start> is ``^/regex/'', it will search from the start of file.
 If <end> is a regex, it will search
 starting at the line given by <start>.
 +
diff --git a/line-range.c b/line-range.c
index bbf3c0f..7048489 100644
--- a/line-range.c
+++ b/line-range.c
@@ -59,8 +59,14 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 		return term;
 	}
 
-	if (begin < 0)
-		begin = -begin;
+	if (begin < 0) {
+		if (spec[0] != '^')
+			begin = -begin;
+		else {
+			begin = 1;
+			spec++;
+		}
+	}
 
 	if (spec[0] != '/')
 		return spec;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index b963d36..5a7d7c7 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -323,6 +323,23 @@ test_expect_success 'blame -L /RE/ (relative: end-of-file)' '
 	test_must_fail $PROG -L, -L/$/ file
 '
 
+test_expect_success 'blame -L ^/RE/ (absolute)' '
+	check_count -L3,3 -L^/dog/,+2 A 1 B2 1
+'
+
+test_expect_success 'blame -L ^/RE/ (absolute: no preceding range)' '
+	check_count -L^/dog/,+2 A 1 B2 1
+'
+
+test_expect_success 'blame -L ^/RE/ (absolute: not found)' '
+	test_must_fail $PROG -L4,4 -L^/tambourine/ file
+'
+
+test_expect_success 'blame -L ^/RE/ (absolute: end-of-file)' '
+	n=$(expr $(wc -l <file) + 1) &&
+	check_count -L$n -L^/$/,+2 A 1 C 1 E 1
+'
+
 test_expect_success 'setup -L :regex' '
 	tr Q "\\t" >hello.c <<-\EOF &&
 	int main(int argc, const char *argv[])
@@ -464,3 +481,7 @@ test_expect_success 'blame -L X,+N (non-numeric N)' '
 test_expect_success 'blame -L X,-N (non-numeric N)' '
 	test_must_fail $PROG -L1,-N file
 '
+
+test_expect_success 'blame -L ,^/RE/' '
+	test_must_fail $PROG -L1,^/99/ file
+'
-- 
1.8.4.rc1.409.gbd48715
