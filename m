From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 14:19:36 -0800
Message-ID: <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 30 23:19:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0mYH-0007wu-Hy
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 23:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWL3WTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 17:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWL3WTi
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 17:19:38 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64415 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030354AbWL3WTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 17:19:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061230221937.CCTJ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 17:19:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5AJr1W00B1kojtg0000000; Sat, 30 Dec 2006 17:18:51 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 30 Dec 2006 12:20:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35634>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sat, 30 Dec 2006, Marco Costalba wrote:
>>
>>> When 'commitencoding' variable is set in config file then git-rev-list
>>> called with --header option sends also the encoding information.
>>
>> As Jakub pointed out, qgit should not expect to know all headers. I am 
>> very sorry, since I said I looked at all parsers of the commit header in 
>> git, but that was _only_ git, and no porcelains.
>>
>> Please fix qgit, since I really consider this a bug.
>
> I have to agree with Johannes.  In principle Porcelains should
> be prepared to see and ignore unknown headers.
>
> However, this commit created by `commit-tree` certalinly can be
> improved.
> ...

Another thing.  I think it would make sense to remove "encoding"
header after pretty_print_commit successfully re-codes the
buffer.  An alternative is to rewrite "encoding" header to show
which encoding the log now uses (and omit it if it is UTF-8).

The attached patch does the latter, but I think removing the
header altogether in this case would make it easier to use
overall.  If you want to, you can change

	if (is_encoding_utf8(encoding))

in the patch with "if (1)" (the above macro is what was
introduced in my previous patch).

Pro for having "encoding" rewritten as this patch does is that
the output is still self-identifying.  You can tell what
encoding you are supposed to interpret the log messages in.  Con
against it is that the output is after re-coding as the user
asked (either with the config or --encoding=<encoding> option),
and the extra header becomes redundant information.

-- >8 --

 commit.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index e13b9cb..bf82fe8 100644
--- a/commit.c
+++ b/commit.c
@@ -624,6 +624,48 @@ static char *get_header(const struct commit *commit, const char *key)
 	}
 }
 
+static char *replace_encoding_header(char *buf, char *encoding)
+{
+	char *encoding_header = strstr(buf, "\nencoding ");
+	char *end_of_encoding_header;
+	int encoding_header_pos;
+	int encoding_header_len;
+	int new_len;
+	int need_len;
+	int buflen = strlen(buf) + 1;
+
+	if (!encoding_header)
+		return buf; /* should not happen but be defensive */
+	encoding_header++;
+	end_of_encoding_header = strchr(encoding_header, '\n');
+	if (!end_of_encoding_header)
+		return buf; /* should not happen but be defensive */
+	end_of_encoding_header++;
+
+	encoding_header_len = end_of_encoding_header - encoding_header;
+	encoding_header_pos = encoding_header - buf;
+
+	if (is_encoding_utf8(encoding)) {
+		/* we have re-coded to UTF-8; drop the header */
+		memmove(encoding_header, end_of_encoding_header,
+			buflen - (encoding_header_pos + encoding_header_len));
+		return buf;
+	}
+	new_len = strlen(encoding);
+	need_len = new_len + strlen("encoding \n");
+	if (encoding_header_len < need_len) {
+		buf = xrealloc(buf, buflen + (need_len - encoding_header_len));
+		encoding_header = buf + encoding_header_pos;
+		end_of_encoding_header = encoding_header + encoding_header_len;
+	}
+	memmove(end_of_encoding_header + (need_len - encoding_header_len),
+		end_of_encoding_header,
+		buflen - (encoding_header_pos + encoding_header_len));
+	memcpy(encoding_header + 9, encoding, strlen(encoding));
+	encoding_header[9 + new_len] = '\n';
+	return buf;
+}
+
 static char *logmsg_reencode(const struct commit *commit)
 {
 	char *encoding;
@@ -642,6 +684,8 @@ static char *logmsg_reencode(const struct commit *commit)
 		return NULL;
 	}
 	out = reencode_string(commit->buffer, output_encoding, encoding);
+	out = replace_encoding_header(out, output_encoding);
+
 	free(encoding);
 	if (!out)
 		return NULL;
