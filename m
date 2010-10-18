From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] fast-import: Let importers retrieve blobs
Date: Mon, 18 Oct 2010 03:50:02 -0500
Message-ID: <20101018085002.GC3979@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101018073605.GF22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 10:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7lTZ-0007g9-BN
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 10:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0JRIxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 04:53:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43656 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0JRIxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 04:53:39 -0400
Received: by ywi6 with SMTP id 6so214954ywi.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7I3wE+//s1JQ4xxXAvVfltmWZ2+6QOtO9wcRVzHNazo=;
        b=Nm/onm3TAFMN7KQV+f9V0pzYC6VhL0mUBctS6HwuGiKIWavjv4ppQKHKRKfjRR6IMM
         YxMl/IomSL1SAmUk8aF2/iRucswd5O4v+YtArtpvrPozVfZylU9/IzVbTXY/rC0WEJmi
         iauTmd+/7/03yxAlwCRTlAJSarysJ4x5YK47c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KU0q0cIqRVqud9hj20FuS4JGAw2Fbr2fCGdodLeXvSHPJe8EvMtSB/IMV9kLSjakqg
         Fv74OoIwSP9td5RwyYPo9PoIbVO4P66ScPSRYkfbGcKgaSDy44ZZBKqzvwGqMzYAbHZe
         6zxkQF9fYc02GXiPJn7IGsGRmVmnfuk0zKi1I=
Received: by 10.150.135.20 with SMTP id i20mr1954688ybd.120.1287392018423;
        Mon, 18 Oct 2010 01:53:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g6sm21706489anh.11.2010.10.18.01.53.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 01:53:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018073605.GF22376@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159238>

Ramkumar Ramachandra wrote:

> Note to self: I didn't notice write_in_full in wrapper.c
> earlier. Returns the actual size written to the fd from the buffer.

Yeah, write_in_full() is write() without the partial-read semantics
when interrupted by a signal, on Windows, or encountering an empty
pipe.

>> +static void option_cat_blob_fd(const char *fd)
>> +{
>> +	unsigned long n = strtoul(fd, NULL, 0);
>> +	if (n > (unsigned long) INT_MAX)
>> +		die("--cat-blob-fd cannot exceed %d", INT_MAX);
>> +	cat_blob_fd = (int) n;
>> +}
>> +
>
> You don't display an appropriate error when n < 0.

How can n be < 0?  strtoul returns an unsigned long.

But more to the point, yes, this does not return an appropriate
error when "--cat-blob-fd=" is not followed by an unsigned
integer.  At least it's consistent with --depth=nonsense et al.

Rough patch below (needs tests).

> Ok. I'm eager to see this go through to `master`.
> Reviewed-by: Ramkumar Ramachandra <artagnon@gmail.com>

Thanks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/fast-import.c b/fast-import.c
index eb6860d..20023c1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2822,16 +2822,25 @@ static void option_date_format(const char *fmt)
 		die("unknown --date-format argument %s", fmt);
 }
 
+static unsigned long ulong_arg(const char *arg)
+{
+	char *endptr;
+	unsigned long rv = strtoul(arg, &endptr, 0);
+	if (endptr == arg || *endptr)
+		die("%s: argument must be an unsigned integer", arg);
+	return rv;
+}
+
 static void option_depth(const char *depth)
 {
-	max_depth = strtoul(depth, NULL, 0);
+	max_depth = ulong_arg(depth);
 	if (max_depth > MAX_DEPTH)
 		die("--depth cannot exceed %u", MAX_DEPTH);
 }
 
 static void option_active_branches(const char *branches)
 {
-	max_active_branches = strtoul(branches, NULL, 0);
+	max_active_branches = ulong_arg(branches);
 }
 
 static void option_export_marks(const char *marks)
@@ -2842,7 +2851,7 @@ static void option_export_marks(const char *marks)
 
 static void option_cat_blob_fd(const char *fd)
 {
-	unsigned long n = strtoul(fd, NULL, 0);
+	unsigned long n = ulong_arg(fd);
 	if (n > (unsigned long) INT_MAX)
 		die("--cat-blob-fd cannot exceed %d", INT_MAX);
 	cat_blob_fd = (int) n;
