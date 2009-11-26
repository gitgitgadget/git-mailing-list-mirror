From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 03/11] mingw: implement syslog
Date: Thu, 26 Nov 2009 22:23:22 +0100
Message-ID: <200911262223.22777.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-3-git-send-email-kusmabite@gmail.com> <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 22:23:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDlod-0007ir-KE
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZKZVXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 16:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZKZVXb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:23:31 -0500
Received: from [93.83.142.38] ([93.83.142.38]:58939 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751445AbZKZVXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 16:23:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DFF0B19F632;
	Thu, 26 Nov 2009 22:23:22 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133834>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> +void syslog(int priority, const char *fmt, ...) {

Style: Brace goes to next line.

> +	struct strbuf msg;
> +	va_list va;
> +	WORD logtype;
> +
> +	strbuf_init(&msg, 0);
> +	va_start(va, fmt);
> +	strbuf_vaddf(&msg, fmt, va);
> +	va_end(va);

I would

	const char* arg;
	if (strcmp(fmt, "%s"))
		die("format string of syslog() not implemented")
	va_start(va, fmt);
	arg = va_arg(va, char*);
	va_end(va);

because we have exactly one invocation of syslog(), which passes "%s" as 
format string. Then strbuf_vaddf is not needed. Or even simpler: declare the 
function as

void syslog(int priority, const char *fmt, const char*arg);

> +	ReportEventA(ms_eventlog,
> +	    logtype,
> +	    (WORD)NULL,
> +	    (DWORD)NULL,
> +	    NULL,
> +	    1,
> +	    0,
> +	    (const char **)&msg.buf,
> +	    NULL);

Why do you pass NULL and apply casts? The first one gives a warning.

Did you read this paragraph in the documentation?
http://msdn.microsoft.com/en-us/library/aa363679(VS.85).aspx

"Note that the string that you log cannot contain %n, where n is an integer 
value (for example, %1) because the event viewer treats it as an insertion 
string. ..."

How are the chances that this condition applies to our use of the function?

-- Hannes
