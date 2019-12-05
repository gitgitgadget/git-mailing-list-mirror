Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A22C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17B022525
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6Yg99ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfLENmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:42:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57603 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfLENmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 08:42:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 125E496233;
        Thu,  5 Dec 2019 08:42:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=407dAKLhtNAeTd+kvNUz+s4XuDc=; b=Y6Yg99
        jiVyqyGPRWmVMCZCCwNuhQaHlNLBQRAsVpw7OdD/5hD6DT1vyM381tpuRKO+ZEGx
        z0JphnG/yMxXbWILfZuxC25H4L6da2NslDe3PCF84jrvCTVOSQ7Gemycg3aVwy4n
        4+4HRrPwqUCTpekOSZM7F6F9TvLPRA6NGznjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zd0bFKuCtdexy6fcRfMl7meG6BH7ZaZH
        qyZ+iaOVXQRFHV1YnFPdaqS52KvIq6NgQbla/KJZco8rfZfTd7fqhL23SCVmlicn
        uqHPqefRihQMeaIUVLUzCELzzlTdMYjw/BZBNt9hPGODZ7cEM6dhNMbdOvmW7+MF
        c+5akwdQCCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A44B96232;
        Thu,  5 Dec 2019 08:42:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4222996231;
        Thu,  5 Dec 2019 08:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v4 07/11] git-p4: Add a helper class for stream writing
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <10dc059444b965c3db3fda5600de64da32de53b4.1575498578.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 05:42:01 -0800
In-Reply-To: <10dc059444b965c3db3fda5600de64da32de53b4.1575498578.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Wed, 04 Dec 2019 22:29:33
        +0000")
Message-ID: <xmqqo8wm28k6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05189BDE-1765-11EA-A88C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> This is a transtional commit that does not change current behvior.  It adds a new class Py23File.

Perhaps s/transitional/preparatory/?  It does not change the
behaviour because nobody uses the class yet, if I understand
correctly.  Which is fine.

It is kind of surprising that each project needs to reinvent and
maintain a wrapper class like this one, as what the new class does
smells quite generic.

> Following the Python recommendation of keeping text as unicode internally and only converting to and from bytes on input and output, this class provides an interface for the methods used for reading and writing files and file like streams.
>
> Create a class that wraps the input and output functions used by the git-p4.py code for reading and writing to standard file handles.
>
> The methods of this class should take a Unicode string for writing and return unicode strings in reads.  This class should be a drop-in for existing file like streams
>
> The following methods should be coded for supporting existing read/write calls:
> * write - this should write a Unicode string to the underlying stream
> * read - this should read from the underlying stream and cast the bytes as a unicode string
> * readline - this should read one line of text from the underlying stream and cast it as a unicode string
> * readline - this should read a number of lines, optionally hinted, and cast each line as a unicode string
>
> The expression "cast as a unicode string" is used because the code should use the AS_BYTES() and AS_UNICODE() functions instead of cohercing the data to actual unicode strings or bytes.  This allows python 2 code to continue to use the internal "str" data type instead of converting the data back and forth to actual unicode strings. This retains current python2 support while python3 support may be incomplete.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit 12919111fbaa3e4c0c4c2fdd4f79744cc683d860)
> ---
>  git-p4.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 7ac8cb42ef..0da640be93 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4182,6 +4182,72 @@ def run(self, args):
>              print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
>          return True
>  
> +class Py23File():
> +    """ Python2/3 Unicode File Wrapper 
> +    """
> +    
> +    stream_handle = None
> +    verbose       = False
> +    debug_handle  = None
> +   
> +    def __init__(self, stream_handle, verbose = False):
> +        """ Create a Python3 compliant Unicode to Byte String
> +            Windows compatible wrapper
> +
> +            stream_handle = the underlying file-like handle
> +            verbose       = Boolean if content should be echoed
> +        """
> +        self.stream_handle = stream_handle
> +        self.verbose       = verbose
> +
> +    def write(self, utf8string):
> +        """ Writes the utf8 encoded string to the underlying 
> +            file stream
> +        """
> +        self.stream_handle.write(as_bytes(utf8string))
> +        if self.verbose:
> +            sys.stderr.write("Stream Output: %s" % utf8string)
> +            sys.stderr.flush()
> +
> +    def read(self, size = None):
> +        """ Reads int charcters from the underlying stream 
> +            and converts it to utf8.
> +
> +            Be aware, the size value is for reading the underlying
> +            bytes so the value may be incorrect. Usage of the size
> +            value is discouraged.
> +        """
> +        if size == None:
> +            return as_string(self.stream_handle.read())
> +        else:
> +            return as_string(self.stream_handle.read(size))
> +
> +    def readline(self):
> +        """ Reads a line from the underlying byte stream 
> +            and converts it to utf8
> +        """
> +        return as_string(self.stream_handle.readline())
> +
> +    def readlines(self, sizeHint = None):
> +        """ Returns a list containing lines from the file converted to unicode.
> +
> +            sizehint - Optional. If the optional sizehint argument is 
> +            present, instead of reading up to EOF, whole lines totalling 
> +            approximately sizehint bytes are read.
> +        """
> +        lines = self.stream_handle.readlines(sizeHint)
> +        for i in range(0, len(lines)):
> +            lines[i] = as_string(lines[i])
> +        return lines
> +
> +    def close(self):
> +        """ Closes the underlying byte stream """
> +        self.stream_handle.close()
> +
> +    def flush(self):
> +        """ Flushes the underlying byte stream """
> +        self.stream_handle.flush()
> +
>  class HelpFormatter(optparse.IndentedHelpFormatter):
>      def __init__(self):
>          optparse.IndentedHelpFormatter.__init__(self)
