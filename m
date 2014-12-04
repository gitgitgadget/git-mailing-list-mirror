From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] doc: document error handling functions and conventions
 (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Wed, 3 Dec 2014 19:01:33 -0800
Message-ID: <20141204030133.GA16345@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:01:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwMfp-0000HD-LK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 04:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbaLDDBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 22:01:41 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34597 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaLDDBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 22:01:40 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so15281395ier.28
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HJgC5jiQrdgJy3gwbWdXgKyrjxKp3iuFu75AcclIWxk=;
        b=VMsl7Mrq1bdKOmUXrywnVLihBImeDDKGfVRmN4mJssYvDLTboQcurJhkD2Ygr44wRR
         FexINiAf/2iTeXMssFD4muX5CmBx0lwXOEzG7V89NAjuLYxDeqtXCj/bd1ct/taIwxue
         AWlaZW1QsedP6TzJta+bh/zGsC2/SP/Y8CEgZUyEgGM+aDCV25huamjkS8K6V9w1mV01
         sEiCvsO9trsKngwJyPDuMf6t57TF/kuKc3/8d9QbxG5HrSUknbeL6RbQfTKetqz421LQ
         JjwXyRmJikD7ESUG6Kh0JpBB4SPawcbkaWUdWErmGXn29AZ7ClK13dxRD/heqOL0IOn5
         5FpQ==
X-Received: by 10.50.142.104 with SMTP id rv8mr11583120igb.23.1417662099969;
        Wed, 03 Dec 2014 19:01:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id k140sm13739879ioe.39.2014.12.03.19.01.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 19:01:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260722>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -extern int copy_fd(int ifd, int ofd);
>> +extern int copy_fd(int ifd, int ofd, struct strbuf *err);
>
> It is not limited to this single function, but what contract do we
> envision this "error messages are given back to the caller via
> strbuf" convention should give between the callers and the callee?

Here's a draft for documentation on that.

 Documentation/technical/api-error-handling.txt | 75 ++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/technical/api-error-handling.txt

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
new file mode 100644
index 0000000..fc68db1
--- /dev/null
+++ b/Documentation/technical/api-error-handling.txt
@@ -0,0 +1,75 @@
+Error reporting in git
+======================
+
+`die`, `usage`, `error`, and `warning` report errors of various
+kinds.
+
+- `die` is for fatal application errors.  It prints a message to
+  the user and exits with status 128.
+
+- `usage` is for errors in command line usage.  After printing its
+  message, it exits with status 129.  (See also `usage_with_options`
+  in the link:api-parse-options.html[parse-options API].)
+
+- `error` is for non-fatal library errors.  It prints a message
+  to the user and returns -1 for convenience in signaling the error
+  to the caller.
+
+- `warning` is for reporting situations that probably should not
+  occur but which the user (and Git) can continue to work around
+  without running into too many problems.  Like `error`, it
+  returns -1 after reporting the situation to the caller.
+
+Customizable error handlers
+---------------------------
+
+The default behavior of `die` and `error` is to write a message to
+stderr and then exit or return as appropriate.  This behavior can be
+overridden using `set_die_routine` and `set_error_routine`.  For
+example, "git daemon" uses set_die_routine to write the reason `die`
+was called to syslog before exiting.
+
+Library errors
+--------------
+
+Functions return a negative integer on error.  Details beyond that
+vary from function to function:
+
+- Some functions return -1 for all errors.  Others return a more
+  specific value depending on how the caller might want to react
+  to the error.
+
+- Some functions report the error to stderr with `error`,
+  while others leave that for the caller to do.
+
+- errno is not meaningful on return from most functions (except
+  for thin wrappers for system calls).
+
+Check the function's API documentation to be sure.
+
+Caller-handled errors
+---------------------
+
+An increasing number of functions take a parameter 'struct strbuf *err'.
+On error, such functions append a message about what went wrong to the
+'err' strbuf.  The message is meant to be complete enough to be passed
+to `die` or `error` as-is.  For example:
+
+	if (ref_transaction_commit(transaction, &err))
+		die("%s", err.buf);
+
+The 'err' parameter will be untouched if no error occured, so multiple
+function calls can be chained:
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, "HEAD", ..., &err) ||
+	    ret_transaction_commit(t, &err))
+		die("%s", err.buf);
+
+The 'err' parameter must be a pointer to a valid strbuf.  To silence
+a message, pass a strbuf that is explicitly ignored:
+
+	if (thing_that_can_fail_in_an_ignorable_way(..., &err))
+		/* This failure is okay. */
+		strbuf_reset(&err);
