From: "H. Peter Anvin" <hpa@zytor.com>
Subject: A shortcoming of the git repo format
Date: Tue, 26 Apr 2005 22:43:13 -0700
Message-ID: <426F2671.1080105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 27 07:38:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfFY-0005GQ-Rr
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 07:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVD0FnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 01:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVD0FnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 01:43:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:14747 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261573AbVD0FnU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 01:43:20 -0400
Received: from [172.27.3.248] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3R5hEHY027089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2005 22:43:17 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Most of git's files are starting to converge toward an RFC822-like 
header with (tag, data) and a free-form section.  This is a good thing. 
  However, there is one problem with this, and that is that without 
knowing every possible tag, a program reading the git repository cannot 
safely tell what is a link to another git object and what is not.  When 
I did my repository conversion tools, I simply assumed any string of 20 
hexadecimal digits was a pointer, but this is probably a bad idea in the 
long run.

Additionally, there is the question of the handling of strings that may 
contain \n or even \0 (which may be necessary for some applications).

One solution to all of this would be to define a quoting standard for 
strings, and simply require that all free-format strings (like the 
author fields) or at least strings that match [0-9a-f]{20}, are always 
quoted.

I propose the following:

- Any string containing control characters or \ must be quoted;
- \xXX produces control characters; other characters following \ are 
verbatim.

Thus,

link 0123456789abcdef0123

... is a link to an object, whereas ...

string \0123456789abcdef0123

... is a string.

string1  This string begins with a space
string2 This string has an embedded newline ("\x0a")

... are both valid strings; the first contains a leading space and the 
second an embedded newline.

I'll implement this and integrate it tomorrow.

	-hpa


