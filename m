From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Wed, 10 Feb 2010 02:12:24 +0100
Message-ID: <201002100212.26157.jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com> <1265711427-15193-5-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 02:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf18B-0005a0-5v
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 02:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab0BJBMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 20:12:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:49346 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0BJBMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 20:12:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so169243fgg.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JyYbwhocGt6XZ9vFFZKYmAMtR2N/SEnfq3/291527v4=;
        b=M/chifhNLx3g3rPKkhkzo1yRlFdhO+/1bNrPrvqOgssFPVbo+Vdw/8GURy6rm3U1yd
         S5/bdCJOeKqt6ehZ3N0WsMnfJORfeq0Avi2Y2MtlYkd+XCFUQZ/XJwaeQQ0UWilAPQSc
         bV3VDylSH2ODLHOnFVSleH+ZVTFdUbXR16SXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LaDPTnLpKkcFmHR47aEU8oLXbl/fmtntkoOUcZv8rW/OZNNp1eu8IN4aGpAgZ/3Jd8
         RcdFW7OTxTlr6x4xl8xLCkYrfrwPvnLmfK/9Ase1o9mnD3t8ZyHVta6/++ijKlMtFcme
         8nNrtTdOPUsqrtIhyE4l0NZrJ12bg5k/yoKs4=
Received: by 10.87.11.25 with SMTP id o25mr1737025fgi.23.1265764351817;
        Tue, 09 Feb 2010 17:12:31 -0800 (PST)
Received: from ?192.168.1.13? (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 12sm8163103fgg.27.2010.02.09.17.12.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 17:12:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265711427-15193-5-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139467>

On Tue, 9 Feb 2010 at 11:30 +0100, Jakub Narebski wrote:

> The cache_fetch subroutine captures output (from STDOUT only, as
> STDERR is usually logged) using either ->push_layer()/->pop_layer()
> from PerlIO::Util submodule (if it is available), or by setting and
> restoring *STDOUT.  Note that only the former could be tested reliably
> to be reliable in t9503 test!

Scratch that, I have just checked that (at least for Apache + mod_cgi,
but I don't think that it matters) the latter solution, with setting
and restoring *STDOUT doesn't work: I would get data in cache (so it
can be restored later), but instead of output I would get Internal Server
Error ("The server encountered an internal error or misconfiguration and
was unable to complete your request.") without even a hint what the
problem was.  Sprinkling "die ...: $!" didn't help to catch this error:
I suspect that the problem is with capturing.

So we either would have to live with non-core PerlIO::Util or (pure Perl)
Capture::Tiny, or do the 'print -> print $out' patch...

[....]
> Capturing gitweb output
> =======================
> When output (response) caching is enabled, the caching mechanism has to
> capture gitweb output (perhaps while printing it to standard output) to
> save it to cache, unless the data is available in cache and not expired.
> 
> Because die_error uses 'exit', and because it uses git_header_html and
> other printing subroutines (which output has to be captured in other
> situations), it needs to disable caching, unless we are "tee"-ing.
> Otherwise we would get no output from die_error (because it is captured),
> but also we would not get data to be saved in cache and printed, because
> 'exit' in die_error would exit capture, too.  This restricts methods and
> modules that can be used to capture output.
> 
> Below there are presented various considered and used ways of capturing the
> output, or "tee"-ing it (capturing while printing), with their advantages
> and disadvantages.
> 
> 
> Capturing output (capture)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
[...]

> 5. Without 'print <sth>' to 'print $out <sth>' change to gitweb, one can try
>    manipulating *STDOUT directly, first saving *STDOUT or \*STDOUT to some
>    variable, then setting *STDOUT = $data_fh, where $data_fh is filehandle
>    opened to in-memory file.
> 
>    This seems to work, does not require large patch to gitweb, and does not
>    require extra (non-core) Perl module.  Nevertheless it seems fragile with
>    respect to restoring STDOUT, and even though basic tests (not included)
>    of this mechanism producted expected result, I wasn't able to write
>    working tests when using this method.
> 
>    We could probably examine how Capture::Tiny does it, and reuse (copy)
>    relevant parts of code, perhaps duplicating STDOUT, closing it and then
>    reopening as in-memory filehandle.
> 
>    YMMV (Your Mileage May Vary).

-- 
Jakub Narebski
Poland
