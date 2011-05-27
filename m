From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/3] diff.c: omit hidden entries from namelen
 calculation with --stat
Date: Fri, 27 May 2011 10:43:32 -0700
Message-ID: <7vvcwwrqd7.fsf@alter.siamese.dyndns.org>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
 <b47e2f0865bac1ad0e7b777ce9f27493292c502c.1306499600.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 27 19:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ14c-0007tz-Us
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 19:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab1E0Rnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 13:43:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1E0Rnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 13:43:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AD1D5790;
	Fri, 27 May 2011 13:45:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LLnE+KSnrlK+gDMkOHMoxeXxCf8=; b=EgbfoX
	tKpCHQzEuAFiBbVq8jRNgij2bY2t5QU+I2QZ3bkL6Q+V6i2AMb+J2GjNy5NY3QMu
	s5bJkQ8azS/rLh4pucQvkzE0IF8CO9IHEUSkQ3V7wgxTkPvCMNIzRxKTfV627kPT
	UZrx9TgjG5d1YutoB10aZGPIxLPLBaRT49gvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K61VHMLs4COrm1Xz4daE7z6KKEYub+rD
	7rs4wyNeGyhYaKfycOgyA+Q+L+FQ40rMTxFnWH+i+KL6f+Sv1kD913Nl+jEilcxc
	TnVNoeBzUnU/NHRp0XLTvU0I8OWNM4nXmR2pt96Z6JCtk7LKA1clz/yMgIFUPxIT
	SvmenmJHBKc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02CC4578F;
	Fri, 27 May 2011 13:45:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D9E5578E; Fri, 27 May 2011
 13:45:41 -0400 (EDT)
In-Reply-To: <b47e2f0865bac1ad0e7b777ce9f27493292c502c.1306499600.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 27 May 2011 14:36:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25E56762-8889-11E0-B7AB-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174632>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, --stat calculates the longest name from all items but then
> drops some (mode changes) from the output later on.
>
> Instead, drop them from the namelen generation and calculation.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This optimizes (tightens) the display potentially, but we never had tests
> which are sensitive to that.

More importantly I think this is a good first step in the right direction
to reduce the duplicated code that need to implement the same logic.

However, you missed another instance in show_shortstats() no?

I am wondering if it would make it easier to both read and maintain if you
add a boolean field "changed" to "struct diffstat_file", and set it at the
end of builtin_diffstat(), and have these places all check that field.

A possible alternative is not to put such an unchanged entry in the struct
diffstat_t in the first place so that nobody has to worry about it. Right
now, show_numstat() does show 0/0 entries (i.e. only mode change), while
shortstat and normal stat do not, but I somehow have a feeling that this
difference is not by design but by accident.  Besides, --numstat that only
says 0/0 is not useful in practice without --summary.

    $ edit diff.c
    $ chmod +x Makefile
    $ git diff --stat
     diff.c |   26 ++++++++++++++------------
    $ git diff --numstat
    0       0       Makefile
    14      12      diff.c
    $ git diff --numstat --summary
    0       0       Makefile
    14      12      diff.c
     mode change 100644 => 100755 Makefile

Getting rid of an unchanged entry from the diffstat array upfront will
change the behaviour of numstat, but I suspect that it change things in a
better way, making the result consistent with the textual version.

The patch below, diff.c shows that approach, while ndiff.c shows the extra
boolean "changed" approach.

What do you think?

 diff.c            |    7 +++++++
 diff.c => ndiff.c |   26 ++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 8f4815b..e2ee70a 100644
--- a/diff.c
+++ b/diff.c
@@ -2267,6 +2267,13 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 			      &xpp, &xecfg);
 	}
 
+	if (!data->is_renamed && !data->added && !data->deleted) {
+		diffstat->nr--;
+		free(data->name);
+		free(data->from_name);
+		free(data);
+	}
+
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 }
diff --git a/diff.c b/ndiff.c
similarity index 99%
copy from diff.c
copy to ndiff.c
index 8f4815b..1620053 100644
--- a/diff.c
+++ b/ndiff.c
@@ -1222,6 +1222,7 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
+		unsigned changed:1;
 		uintmax_t added, deleted;
 	} **files;
 };
@@ -1350,6 +1351,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
+
+		if (!file->changed)
+			continue;
 		fill_print_name(file);
 		len = strlen(file->print_name);
 		if (max_len < len)
@@ -1381,6 +1385,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		uintmax_t deleted = data->files[i]->deleted;
 		int name_len;
 
+		if (!data->files[i]->changed) {
+			total_files--;
+			continue;
+		}
+
 		/*
 		 * "scale" the filename
 		 */
@@ -1415,11 +1424,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			fprintf(options->file, "  Unmerged\n");
 			continue;
 		}
-		else if (!data->files[i]->is_renamed &&
-			 (added + deleted == 0)) {
-			total_files--;
-			continue;
-		}
 
 		/*
 		 * scale the add/delete
@@ -1457,15 +1461,12 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 	for (i = 0; i < data->nr; i++) {
 		if (!data->files[i]->is_binary &&
 		    !data->files[i]->is_unmerged) {
-			int added = data->files[i]->added;
-			int deleted= data->files[i]->deleted;
-			if (!data->files[i]->is_renamed &&
-			    (added + deleted == 0)) {
+			if (!data->files[i]->changed) {
 				total_files--;
-			} else {
-				adds += added;
-				dels += deleted;
+				continue;
 			}
+			adds += data->files[i]->added;
+			dels += data->files[i]->deleted;
 		}
 	}
 	if (options->output_prefix) {
@@ -2266,6 +2267,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 			      &xpp, &xecfg);
 	}
+	data->changed = data->is_renamed || data->added || data->deleted;
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
