From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an option to require a filter to be successful
Date: Thu, 16 Feb 2012 16:03:58 -0800
Message-ID: <7vobsywck1.fsf@alter.siamese.dyndns.org>
References: <1329434328-26621-1-git-send-email-jehan@orb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 01:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyBJ5-0004RT-PM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 01:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab2BQAED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 19:04:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2BQAEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 19:04:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBB1758E;
	Thu, 16 Feb 2012 19:04:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SXwXDmOl/IUhy5fp3i07bEZGjK0=; b=dzsoPQ
	a3Xou3/emmWrDOIC4YdCv8n14LJqlDvVIssIUH45se4uY6McBmS1bsYcL+tdK85X
	tKQ7Dnoh0ZoHMEqLviNfyTTOyss48XnqdGk+v2buK5r17gLOy9sYTlxZ4rwMPatP
	6qgSkqWeiPWCeOkuN4OKe6QjdBLwvnAYIKejo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEA3+NNDlw133mcGbvjQVYaWCw1pNTm1
	+E0VIR5aup/ySp1fTZwyrRCMOQUKD1wcgplOx7QjfTmeR2cfzt8gL5eXypUg3BhK
	PnF3trqTnNyQ3lzYmQZcWOZ1AD2YUnjyPTTXL/jmIFXrMH5Oa9xOVy27aXZj+5vD
	sXM9GuSkC5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF9C8758D;
	Thu, 16 Feb 2012 19:04:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54180758C; Thu, 16 Feb 2012
 19:04:00 -0500 (EST)
In-Reply-To: <1329434328-26621-1-git-send-email-jehan@orb.com> (Jehan Bing's
 message of "Thu, 16 Feb 2012 15:18:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4EBD7F8-58FA-11E1-8EEE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190925>

Jehan Bing <jehan@orb.com> writes:

> By default, if a filter driver fails, the unfiltered content will be
> used. This patch adds a "filter.<name>.required" config option. When
> set to true, git will abort if the filter fails.
>
> A typical usage would be for a "bigfile" filter, where the smudge
> command can fail if the file is not available locally. Without the
> "required", the content of repository, i.e. a reference to the real
> content, will be checked out. Unless one saves the output logs, it
> then fairly easy to lose track of what "bigfile" wasn't checked out
> correctly.
>
> Another example would be for an encrypted repository if the clean
> command (encryption) fails. Without the "required", an unencrypted
> content could be stored in the repository by mistake.

The above describes sample situations where setting the "required" may be
very useful, without saying anything about in what situation it might be
useful to set it to "optional".

Which makes the reader wonder why this is not done as a bugfix patch that
unconditionally propagates the failure from the filter up the callchain.

That is because the first sentence in the message is too weak. It needs to
be followed by something like:

    This is because the content filtering is done to massage the content
    into a shape that is more convenient for the platform, filesystem, and
    the user to use.  The key phrase here is "more convenient" and not
    "turning something unusable into usable".

which is what the part of gitattributes documentation shown in the context
says.

That is a statement of principle.  And according to that principle, your
configuration option should never exist.

If we are changing that principle and making it configurable, I think the
update to the existing documentation should state things a bit stronger.
We shouldn't be saying "Do not use filter to turn unusable contents to
usable" and in the next breath "But you can use it if you set this at the
same time".  That is simply too confusing.

Here is an attempt to rephrase the part that updates the documentation.

Note that filter.<driver>.required is *NOT* an attribute.  An attribute is
something you attach to paths.


 Documentation/gitattributes.txt |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 25e46ae..39a2654 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -294,16 +294,23 @@ output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
 upon checkin.
 
-A missing filter driver definition in the config is not an error
-but makes the filter a no-op passthru.
+One use of the content filtering is to massage the content into a shape
+that is more convenient for the platform, filesystem, and the user to use.
 
-The content filtering is done to massage the content into a
-shape that is more convenient for the platform, filesystem, and
-the user to use.  The key phrase here is "more convenient" and not
-"turning something unusable into usable".  In other words, the
-intent is that if someone unsets the filter driver definition,
-or does not have the appropriate filter program, the project
-should still be usable.
+Another use of the content filtering is to store the content that cannot
+be directly used in the repository (e.g. an UUID that refers to the true
+content stored outside git, or an encrypted content) and turn it into a
+usable form upon checkout (e.g. download the external content, decrypt the
+encrypted content).
+
+These two filters behave differently, and by default, a filter is taken as
+the former, massaging the contents into more convenient shape.  A missing
+filter driver definition in the config, or a filter driver that exits with
+a non-zero status, is not an error but makes the filter a no-op passthru.
+
+You can declare that a filter turns a content that by itself is unusable
+into usable by setting filter.<drivername>.required configuration variable
+to `true`.
 
 For example, in .gitattributes, you would assign the `filter`
 attribute for paths.
@@ -335,6 +342,16 @@ input that is already correctly indented.  In this case, the lack of a
 smudge filter means that the clean filter _must_ accept its own output
 without modifying it.
 
+If a filter _must_ succeed in order to make the stored contents usable,
+you can declare that the filter is `required`, in the configuration:
+
+------------------------
+[filter "crypt"]
+	clean = openssl enc ...
+	smudge = openssl enc -d ...
+	required
+------------------------
+
 Sequence "%f" on the filter command line is replaced with the name of
 the file the filter is working on.  A filter might use this in keyword
 substitution.  For example:
