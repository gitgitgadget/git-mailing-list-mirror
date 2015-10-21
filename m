From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/35] libify mailinfo and call it directly from am
Date: Wed, 21 Oct 2015 16:15:42 -0700
Message-ID: <xmqqoafru82p.fsf_-_@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 01:15:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp2bp-0004eF-JB
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 01:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbbJUXPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 19:15:47 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755452AbbJUXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 19:15:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D94072449F;
	Wed, 21 Oct 2015 19:15:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJfxQab9R/naxCFh+DqV5s313NM=; b=LEzBi8
	ag7SfezSMN6DsEYWQzwS6HcPu85dnELIx8Q7NiOiPxcZJbFO0dVeGLNsVPPAP+kj
	vo8LlaLZ2MYjTUh4Qkb/y+i9F91kryt78NasK9GRk+Zpr8TIKUGoSZfYJbe2pNYo
	B7YLn08eMQjeSpUc7uHSPT6MIw+k5JiBfcWd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTJc5gx7j82/RrrkfcxSJsvKTsFmri6l
	TAoy32oAT9b4R1gX8Jt04AVlINmBUm6el/IGfX+SUf8aOsI/Vr3wbnwTQ9fHQXKU
	6tjHVndoedATtxeQwLMHoGPvkze31tXuDbbhdm3rqE/8PL+ECJuBJq8m9ZW7mi91
	rSwgZVXLKWM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D19602449E;
	Wed, 21 Oct 2015 19:15:44 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 579712449D;
	Wed, 21 Oct 2015 19:15:44 -0400 (EDT)
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 19 Oct 2015 00:28:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A78DC4B2-7849-11E5-B34B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280028>

The change in the endgame since v3 ($gmane/279832) is almost none
(interdiff attached at the end), so I won't be sending the patches
themselves.  The bulk out of the miniscule interdiff comes from the
fifth "plug strbuf leak" patch.

The patches have been reordered to make the structure of the series
clearer:

Preliminary fixes:

  mailinfo: remove a no-op call convert_to_utf8(it, "")
  mailinfo: fold decode_header_bq() into decode_header()
  mailinfo: fix an off-by-one error in the boundary stack
  mailinfo: explicitly close file handle to the patch output
  mailinfo: plug strbuf leak during continuation line handling

Group related things together and remove forward declarations:

  mailinfo: move handle_boundary() lower
  mailinfo: move read_one_header_line() closer to its callers
  mailinfo: move check_header() after the helpers it uses
  mailinfo: move cleanup_space() before its users
  mailinfo: move definition of MAX_HDR_PARSED closer to its use

Preliminary logic clean-up:

  mailinfo: get rid of function-local static states
  mailinfo: do not let handle_body() touch global "line" directly
  mailinfo: do not let handle_boundary() touch global "line" directly
  mailinfo: do not let find_boundary() touch global "line" directly
  mailinfo: move global "line" into mailinfo() function

Getting rid of the globals:

  mailinfo: introduce "struct mailinfo" to hold globals
  mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
  mailinfo: move global "FILE *fin, *fout" to struct mailinfo
  mailinfo: move filter/header stage to struct mailinfo
  mailinfo: move patch_lines to struct mailinfo
  mailinfo: move add_message_id and message_id to struct mailinfo
  mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
  mailinfo: move metainfo_charset to struct mailinfo
  mailinfo: move check for metainfo_charset to convert_to_utf8()
  mailinfo: move transfer_encoding to struct mailinfo
  mailinfo: move charset to struct mailinfo
  mailinfo: move cmitmsg and patchfile to struct mailinfo
  mailinfo: move [ps]_hdr_data to struct mailinfo
  mailinfo: move content/content_top to struct mailinfo

Libify:

  mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
  mailinfo: keep the parsed log message in a strbuf
  mailinfo: libify

Lifting the error handling to the caller:

  mailinfo: handle charset conversion errors in the caller
  mailinfo: remove calls to exit() and die() deep in the callchain

Endgame:

  am: make direct call to mailinfo

 Makefile           |    1 +
 builtin/am.c       |   42 ++-
 builtin/mailinfo.c | 1055 +---------------------------------------------------
 mailinfo.c         | 1037 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mailinfo.h         |   41 ++
 5 files changed, 1122 insertions(+), 1054 deletions(-)
 create mode 100644 mailinfo.c
 create mode 100644 mailinfo.h

-- 
2.6.2-377-g450896c


(Interdiff)

diff --git a/mailinfo.c b/mailinfo.c
index 49eaa99..e157ca6 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -729,6 +729,8 @@ static int is_rfc2822_header(const struct strbuf *line)
 
 static int read_one_header_line(struct strbuf *line, FILE *in)
 {
+	struct strbuf continuation = STRBUF_INIT;
+
 	/* Get the first part of the line. */
 	if (strbuf_getline(line, in, '\n'))
 		return 0;
@@ -750,7 +752,6 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 	 */
 	for (;;) {
 		int peek;
-		struct strbuf continuation = STRBUF_INIT;
 
 		peek = fgetc(in); ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
@@ -761,6 +762,7 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 		strbuf_rtrim(&continuation);
 		strbuf_addbuf(line, &continuation);
 	}
+	strbuf_release(&continuation);
 
 	return 1;
 }
diff --git a/mailinfo.h b/mailinfo.h
index 5bf257d..93776a7 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -14,7 +14,7 @@ struct mailinfo {
 	int keep_non_patch_brackets_in_subject;
 	int add_message_id;
 	int use_scissors;
-	int use_inbody_headers; /* defaults to 1 */
+	int use_inbody_headers;
 	const char *metainfo_charset;
 
 	struct strbuf *content[MAX_BOUNDARIES];
