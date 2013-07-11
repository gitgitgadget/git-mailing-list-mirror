From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] allow more sources for config values
Date: Thu, 11 Jul 2013 16:26:02 -0700
Message-ID: <7vk3kwptkl.fsf@alter.siamese.dyndns.org>
References: <20130711223614.GA26477@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 01:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxQFl-0003KI-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 01:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab3GKX0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 19:26:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab3GKX0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 19:26:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60C933008A;
	Thu, 11 Jul 2013 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQU8QNlg/ogxuN/K7WI89UZoNfM=; b=bPfr8O
	7ZP8tS+PeafApt1KzvkHvIWdGaMtYUHiDMGvHJACGxg2uOXvu5RVwz+AQBWl9WF/
	ZYTCGf2yCs13JKd06Ekw8Ux4h5ql7jF3kmgx/dfDqdgSKltsjQqHDNMvsb+T61xo
	dCO2XYdexzJ51OC7N3PwADd9xe5n126hfbZ90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D8Skuj0w8LTeYEHPTKhtCueOhAGkoJx7
	1I1DwdqG02L7EvW6JeVPd79qIixHBKDGK2oyoiLs+dnHRtfmfiiAX7ICqjqeAnK7
	KO2YywWXAa0nvhRLedhrKnik+EnEmo/gN5OWaRU8vYGVoww0ZcHP6voCVyQqg1qz
	xs3UWeXLqrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DF430088;
	Thu, 11 Jul 2013 23:26:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABFAE30085;
	Thu, 11 Jul 2013 23:26:03 +0000 (UTC)
In-Reply-To: <20130711223614.GA26477@book-mint> (Heiko Voigt's message of
	"Fri, 12 Jul 2013 00:36:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41127A50-EA81-11E2-9C54-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230151>

Thanks.

The differences since the last round I see are these.  And I think
the series overall makes sense (I haven't look hard enough to pick
any nits yet, though).

Thanks, will queue.

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9ae2508..f0e179e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -118,6 +118,13 @@ See also <<FILES>>.
 --file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
 
+--blob blob::
+	Similar to '--file' but use the given blob instead of a file. E.g.
+	you can use 'master:.gitmodules' to read values from the file
+	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
+	section in linkgit:gitrevisions[7] for a more complete list of
+	ways to spell blob names.
+
 --remove-section::
 	Remove the given section from the configuration file.
 
diff --git a/config.c b/config.c
index a8d3dcf..680dd6d 100644
--- a/config.c
+++ b/config.c
@@ -948,7 +948,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
+static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 {
 	int ret;
 
@@ -986,7 +986,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		top.ungetc = config_file_ungetc;
 		top.ftell = config_file_ftell;
 
-		ret = do_config_from_source(&top, fn, data);
+		ret = do_config_from(&top, fn, data);
 
 		fclose(f);
 	}
@@ -1007,7 +1007,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.ungetc = config_buf_ungetc;
 	top.ftell = config_buf_ftell;
 
-	return do_config_from_source(&top, fn, data);
+	return do_config_from(&top, fn, data);
 }
 
 static int git_config_from_blob_sha1(config_fn_t fn,
