From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] update-index: upgrade/downgrade on-disk index version
Date: Wed, 04 Apr 2012 09:58:44 -0700
Message-ID: <7vty0za0xn.fsf_-_@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <CAFfmPPOqb8Kn-LERyiLKL838DKw=X6=CTV1x0s8coPgAvNLUdw@mail.gmail.com>
 <7v7gxvbjfy.fsf@alter.siamese.dyndns.org>
 <7vy5qba10j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 18:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTXs-0006QY-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 18:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab2DDQ6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 12:58:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab2DDQ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 12:58:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D78287D0F;
	Wed,  4 Apr 2012 12:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=miPgkIkU74xuEN93IDPiCGK7IZE=; b=oM/yZP
	3dLlV5f70biPkTUOdyjdxK+GuoQYH8uhNOluQQgczsRtgREcjZbcXEgH9Ox0C56c
	XXd+tpgrh6fOmXmwtspk1WgMeEzUHhnr5erKCrGKUvMi69uD7JOBJ9So2bDSW7C2
	iSZs0NPtmyRmVOLK5AloJGSIAY4BexXBON9lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YRzjs1QrdVWoZT1oRUYxyVw/kkm3gxfj
	/XJ495lepvKSopnJp2a9wDesUM1dXAQLdSYO7gG2ff7mgpz//dFTQUlSsY01DeAO
	U/yzJXXX1CuCx9fjTlGaCTzxnnCZwLXThFD2gCjzP8EbBYJnlJJ1Ks6eamFO4h4l
	5YHQOE4iUZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE85B7D0E;
	Wed,  4 Apr 2012 12:58:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FBFC7D0D; Wed,  4 Apr 2012
 12:58:46 -0400 (EDT)
In-Reply-To: <7vy5qba10j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Apr 2012 09:57:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 712BC060-7E77-11E1-B08D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194708>

With the "--index-version <n>" parameter, write the index out in the
specified version.  With this, an index file that is written in newer
format (say v4) can be downgraded to be read by older versions of Git.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And this is the second of the two-patch series to replace 9/9 from
   yesterday's series.

 Documentation/git-update-index.txt |    6 +++++-
 builtin/update-index.c             |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index a3081f4..fd9103b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
-	     [-z] [--stdin]
+	     [-z] [--stdin] [--index-version <n>]
 	     [--verbose]
 	     [--] [<file>...]
 
@@ -143,6 +143,10 @@ you will need to handle the situation manually.
 --verbose::
         Report what is being added and removed from index.
 
+--index-version <n>::
+	Write the resulting index out in the named on-disk format version.
+	The current default version is 2.
+
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
 	separated with NUL character instead of LF.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..5f038d6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -708,6 +708,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int newfd, entries, has_errors = 0, line_termination = '\n';
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
+	int preferred_index_format = 0;
 	char set_executable_bit = 0;
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
@@ -791,6 +792,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			"(for porcelains) forget saved unresolved conflicts",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			resolve_undo_clear_callback},
+		OPT_INTEGER(0, "index-version", &preferred_index_format,
+			    "write index in this format"),
 		OPT_END()
 	};
 
@@ -851,6 +854,17 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 	}
 	argc = parse_options_end(&ctx);
+	if (preferred_index_format) {
+		if (preferred_index_format < INDEX_FORMAT_LB ||
+		    INDEX_FORMAT_UB < preferred_index_format)
+			die("index-version %d not in range: %d..%d",
+			    preferred_index_format,
+			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
+
+		if (the_index.version != preferred_index_format)
+			active_cache_changed = 1;
+		the_index.version = preferred_index_format;
+	}
 
 	if (read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
-- 
1.7.10.rc4.54.g1d5dd3
