From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the
	timezone
Date: Wed, 29 Sep 2010 16:41:08 -0500
Message-ID: <20100929214107.GA4485@capella.cs.uchicago.edu>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 23:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P14Ov-0001A6-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 23:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0I2VlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 17:41:11 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:39670 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0I2VlK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 17:41:10 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 245CBBACD;
	Wed, 29 Sep 2010 16:41:08 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id DCFF9212A1; Wed, 29 Sep 2010 16:41:08 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157608>

Hi Anders,

Anders Kaseorg wrote:
> Some patches have a timezone formatted like '-08:00' instead of
> '-0800' (e.g. http://lwn.net/Articles/131729/)

Odd.  Any idea what tool generates these patches?

> --- a/builtin/apply.c
> +++ b/builtin/apply.c
[...]
> @@ -765,7 +765,9 @@ static int has_epoch_timestamp(const char *nameline)
>  	}
>  
>  	zoneoffset = strtol(timestamp + m[3].rm_so + 1, NULL, 10);
> -	zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
> +	if (m[4].rm_so == m[3].rm_so + 3)
> +		zoneoffset /= 100;
> +	zoneoffset = zoneoffset * 60 + strtol(timestamp + m[4].rm_so, NULL, 10);

Might be clearer to write

	if (timestamp[m[3].rm_so + 3] != ':')

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Maybe something like this on top?

-- 8< --
Subject: apply: handle patches with funny filename and colon in timezone

Some patches have a timezone formatted like '-08:00' instead of
'-0800' in their ---/+++ lines (e.g. http://lwn.net/Articles/131729/).
Take this into account when searching for the start of the timezone
(which is the end of the filename).

This does not actually affect the outcome of patching unless (1) a
file being patched has a non-' ' whitespace character (e.g., tab) in
its filename, or (2) the patch is whitespace-damaged, so the tab
between filename and timestamp has been replaced with spaces.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/apply.c                  |   24 ++++++++++++++++++++++--
 t/t4135-apply-weird-filenames.sh |   16 ++++++++++++++++
 t/t4135/damaged-tz.diff          |    5 +++++
 t/t4135/funny-tz.diff            |    5 +++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 t/t4135/damaged-tz.diff
 create mode 100644 t/t4135/funny-tz.diff

diff --git a/builtin/apply.c b/builtin/apply.c
index 0fa9a8d..7d91d8f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -449,7 +449,7 @@ static char *find_name_gnu(const char *line, char *def, int p_value)
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
-static size_t tz_len(const char *line, size_t len)
+static size_t sane_tz_len(const char *line, size_t len)
 {
 	const char *tz, *p;
 
@@ -467,6 +467,24 @@ static size_t tz_len(const char *line, size_t len)
 	return line + len - tz;
 }
 
+static size_t tz_with_colon_len(const char *line, size_t len)
+{
+	const char *tz, *p;
+
+	if (len < strlen(" +08:00") || line[len - strlen(":00")] != ':')
+		return 0;
+	tz = line + len - strlen(" +08:00");
+
+	if (tz[0] != ' ' || (tz[1] != '+' && tz[1] != '-'))
+		return 0;
+	p = tz + 2;
+	if (!isdigit(*p++) || !isdigit(*p++) || *p++ != ':' ||
+	    !isdigit(*p++) || !isdigit(*p++))
+		return 0;
+
+	return line + len - tz;
+}
+
 static size_t date_len(const char *line, size_t len)
 {
 	const char *date, *p;
@@ -561,7 +579,9 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	if (!isdigit(end[-1]))
 		return 0;
 
-	n = tz_len(line, end - line);
+	n = sane_tz_len(line, end - line);
+	if (!n)
+		n = tz_with_colon_len(line, end - line);
 	end -= n;
 
 	n = short_time_len(line, end - line);
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index 1e5aad5..bf5dc57 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -72,4 +72,20 @@ test_expect_success 'whitespace-damaged traditional patch' '
 	test_cmp expected postimage.txt
 '
 
+test_expect_success 'traditional patch with colon in timezone' '
+	echo postimage >expected &&
+	reset_preimage &&
+	rm -f "post image.txt" &&
+	git apply "$vector/funny-tz.diff" &&
+	test_cmp expected "post image.txt"
+'
+
+test_expect_success 'traditional, whitespace-damaged, colon in timezone' '
+	echo postimage >expected &&
+	reset_preimage &&
+	rm -f "post image.txt" &&
+	git apply "$vector/damaged-tz.diff" &&
+	test_cmp expected "post image.txt"
+'
+
 test_done
diff --git a/t/t4135/damaged-tz.diff b/t/t4135/damaged-tz.diff
new file mode 100644
index 0000000..07aaf08
--- /dev/null
+++ b/t/t4135/damaged-tz.diff
@@ -0,0 +1,5 @@
+diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/post image.txt linux-2.6.12-rc2-mm3/post image.txt
+--- linux-2.6.12-rc2-mm3-vanilla/post image.txt 1969-12-31 16:00:00 -08:00
++++ linux-2.6.12-rc2-mm3/post image.txt 2005-04-12 02:14:06 -07:00
+@@ -0,0 +1 @@
++postimage
diff --git a/t/t4135/funny-tz.diff b/t/t4135/funny-tz.diff
new file mode 100644
index 0000000..998e3a8
--- /dev/null
+++ b/t/t4135/funny-tz.diff
@@ -0,0 +1,5 @@
+diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/post image.txt linux-2.6.12-rc2-mm3/post image.txt
+--- linux-2.6.12-rc2-mm3-vanilla/post image.txt	1969-12-31 16:00:00 -08:00
++++ linux-2.6.12-rc2-mm3/post image.txt	2005-04-12 02:14:06 -07:00
+@@ -0,0 +1 @@
++postimage
-- 
1.6.5
