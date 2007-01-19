From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Fri, 19 Jan 2007 23:44:11 +0100
Message-ID: <200701192344.11972.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701191310.32417.jnareb@gmail.com> <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:43:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82SV-0002XL-KN
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXASWnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXASWnf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:43:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:31474 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbXASWne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:43:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so572137uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 14:43:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e9en6VNDoDFIl6BNkZZhQxn88symuYEhPd5e1qAeKehJMxizUzZFdy78L1c7gW99y/GMdQaQ7Lw/bPpY+GKTRdi8fpMgDUAPJrff+xPH3Mj11qZwv5mNm6acytnNfQBxhEL5YDMboAy3EnT1oncTO/MShZRXPxpsS1Vi5yr87+I=
Received: by 10.67.20.3 with SMTP id x3mr3838844ugi.1169246612937;
        Fri, 19 Jan 2007 14:43:32 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 53sm3171094ugn.2007.01.19.14.43.32;
        Fri, 19 Jan 2007 14:43:32 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37214>

Johannes Schindelin wrote:
> 
> On Fri, 19 Jan 2007, Jakub Narebski wrote:
> 
>> From a bit of testing, as documentation of config file format is 
>> woefully incomplete, (yes, I know I should use the source) _some_ of C 
>> escape sequences aka. character escape codes (CEC) are parsed:
> 
> No, you should not just use the source. You should use the source _and_ 
> complete the documentation.

Something like the patch below? Untested! ("make doc" up to 
git-repo-config.txt compiles, though).

I'm not sure how to tell that you can have [section] if you have
[section "subsection"], but you don't need to. And I probably forgot
to add some information.

And I'm not sure if some behavior should not be changed, for example
allowing _any_ line to be continued with `\`, or that other character
escape sequences and perhaps also octal character sequences should be
allowed (either that or `\b` should not be parsed).

I can send proper patch if requested, but I'd rather above issues
were resolved first.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da7fde5..9544308 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -14,14 +14,53 @@ dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive and only alphanumeric
 characters are allowed. Some variables may appear multiple times.
 
+Syntax
+~~~~~~
+
 The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored. The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored, lines containing strings enclosed in square
-brackets start sections and all the other lines are recognized
-as setting variables, in the form 'name = value'. If there is no equal
-sign on the line, the entire line is taken as 'name' and the variable
-is recognized as boolean "true". String values may be entirely or partially
-enclosed in double quotes; some variables may require special value format.
+ignored.  The '#' and ';' characters begin comments to the end of line,
+blank lines are ignored.
+
+The file consists of sections and variables.  A section begins with
+the name of the section in square brackets and continues until the next
+section begins.  Section names are not case sensitive.  Each variable
+must belong to some section, which means that there must be section
+header before first setting of a variable.
+
+Sections can be further divided into subsections.  To begin a subsection
+put it name in double quotes, separated by space from the section name,
+in the section header, like in example below
+
+	[section "subsection"]
+
+Subsection names can contain whitespace and are case sensitive.  Variables
+may belong directly to a section, or to a given subsection.
+
+All the other lines are recognized as setting variables, in the form
+'name = value'. If there is no equal sign on the line, the entire line
+is taken as 'name' and the variable is recognized as boolean "true".
+Variable names are case insensitive.  There can be more than one value
+for a given variable; we say then that variable is multivalued.
+
+Leading and trailing whitespace in a variable value is discarded.
+Internal whitespace within a variable value is retained verbatim.
+
+String values may be entirely or partially enclosed in double quotes.
+You need to enclose variable value in double quotes if you want to
+preserve leading or trailing whitespace, or if variable value contains
+beginning of comment characters, it means if it contains `#` or `;`.
+Double quote `"` and backslash `\` characters in variable value must
+be escaped: use `\"` for `"`, and `\\` for `\`.
+
+The following escape sequences (beside `\"` and `\\`) are recognized:
+`\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
+and `\b` for backspace (BS).  No other character escape codes, nor octal
+char sequences are valid.
+
+Variable value ending in a `\` is continued on the next line in the 
+customary UNIX fashion.
+
+Some variables may require special value format.
 
 Example
 ~~~~~~~
