From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Mon, 21 Jan 2008 03:04:33 -0800
Message-ID: <7vejcbzbge.fsf@gitster.siamese.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>
	<fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org>
	<7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
	<fn1sk4$uh4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 12:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGuSl-0006yR-Qk
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037AbYAULEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757114AbYAULEl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:04:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbYAULEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:04:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A7AFE4044;
	Mon, 21 Jan 2008 06:04:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E46184040;
	Mon, 21 Jan 2008 06:04:35 -0500 (EST)
In-Reply-To: <fn1sk4$uh4$1@ger.gmane.org> (Mark Junker's message of "Mon, 21
	Jan 2008 11:36:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71260>

Mark Junker <mjscod@web.de> writes:

> Junio C Hamano schrieb:
>
>> I do not know how Macintosh libc implements "struc dirent", but
>> this approach does not work in general.
>
> IMHO there is no need that this approach works in general because this
> is a fix for MacOSX systems only. I also use d_namlen which might not
> be available on other systems. But on MacOSX this works as expected.
>
>> yet you can obtain a path component longer than 256 bytes.
>> Apparently the library allocates longer d_name[] field than what
>> is shown to the user.
>
> This is not a problem either because on MacOSX we get decomposed UTF8
> and we always convert to composed UTF8. This means that the string
> returned from reencode_string will always be smaller than the original
> filename that had to be reencoded.

It is not quite enough that this works Ok on MacOS, if you made
FIX_UTF8_MAC definable in the Makefile.  After all some friendly
and helpful Linux folks might want to enable it with their build
trying to help debugging, right?

In the short term, as long as it safely runs without overrunning
the buffer on MacOS, then that is fine, even though we will need
some protection to prevent this code from getting compiled and
used on Linux with glibc, which does have the issue.

I was specifically talking about this "static" thing.

+static struct dirent temp;


+struct dirent *gitreaddir(DIR *dirp)
+{
+	size_t utf8_len;
+	char *utf8;
+	struct dirent *result;
+	result = readdir(dirp);
+	if (result != NULL) {
+		memcpy(&temp, result, sizeof(struct dirent));
+		utf8 = reencode_string(temp.d_name, "UTF8", "UTF8-MAC");
+		if (utf8 != NULL) {
+			utf8_len = strlen(utf8);
+			temp.d_namlen = (u_int8_t) utf8_len;
+			memcpy(temp.d_name, utf8, utf8_len + 1);
+			free(utf8);
+			result = &temp;
+		}
+	}
+	return result;
+}

You memcpy() what the library gave you in *result to the
statically allocated "temp".  d_name[] in "temp" comes from the
structure definition in the user visible include file, which
could be much shorter than what the library gave you in *result.
The structure definition I showed in my message you are
responding to illustrates the issue.  If MacOS uses a similar
trick to define d_name[256] and sometimes returns much longer
name in *result, you are truncating the name by copying only the
first part of the structure and first 256 bytes of d_name[]. 

But you have a Mac, I don't, so as long as you have verified
that their header has enough room in statically allocated "temp"
to store longest possible name that can be returned from
readdir(), the code is Ok.  I was just being cautious, as I know
the above code has a problem on one platform.
