From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 18:44:13 -0700
Message-ID: <435C3C6D.7000201@zytor.com>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> <7v8xwjx2f9.fsf@assigned-by-dhcp.cox.net> <435C3427.30803@zytor.com> <Pine.LNX.4.64.0510231836020.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:45:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrO0-0003qs-PM
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVJXBo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVJXBo0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:44:26 -0400
Received: from terminus.zytor.com ([192.83.249.54]:40928 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750882AbVJXBoZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 21:44:25 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9O1iAB7005044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Oct 2005 18:44:11 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510231836020.10477@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10522>

Linus Torvalds wrote:
> 
> On Sun, 23 Oct 2005, H. Peter Anvin wrote:
> 
>>If this is meant to dequote shell-quoted paths, it really should be modal.
> 
> It _only_ accepts quoted strings, so it "is" modal. It has one mode: 
> string. And it's a bitch about enforcing it, too (it just dies if it 
> wasn't one).
> 

That wasn't what I meant.  '...' is a modal escape in the shell.  Thus, 
something like this which actually mimics the state machine, at least 
for the potential characters we care about.


#define EMIT(x) { ( ++len < n ) && *dst++ = (x) )

int unquote(char *dst, size_t n, const char *src)
{
	enum state st = { st_zero, st_quote, st_escape };
	int len = 0;
	char c;
	
	while ( (c = *src++) ) {
		switch ( st ) {
		case st_zero:
			if ( c == '\'' )
				st = st_quote;
			else if ( c == '\\' )
				st = st_escape;
			else
				EMIT(c);
			break;
			
		case st_quote:
			if ( c == '\'' )
				st = st_zero;
			else
				EMIT(c);
			break;
			
		case st_escape:
			EMIT(c);
			st = st_zero;
			break;
		}
	}
	
	if ( n )
		*dst = 0;
	
	return (st == st_zero) ? len : -1;
}
