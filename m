From: Stephen Bash <bash@genarts.com>
Subject: Git EOL Normalization
Date: Wed, 25 May 2011 11:20:06 -0400 (EDT)
Message-ID: <29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
References: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 17:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFsw-0002gA-F6
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab1EYPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:20:19 -0400
Received: from hq.genarts.com ([173.9.65.1]:32194 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757812Ab1EYPUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:20:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B52F2EA2316
	for <git@vger.kernel.org>; Wed, 25 May 2011 11:20:14 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y+T5oNLtAH4p for <git@vger.kernel.org>;
	Wed, 25 May 2011 11:20:06 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 967CFEA230A
	for <git@vger.kernel.org>; Wed, 25 May 2011 11:20:06 -0400 (EDT)
In-Reply-To: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174413>

Hi all-

At the office we recently had a few commits flipping end-of-line characters on complete files so I spent some time decoding the man pages on eol, autocrlf, and the text attribute.  From the current man pages I generated the tables below and I'm wondering a) if my interpretation is correct, and b) if there's value in putting these somewhere in the Git wiki (page name suggestions welcome!)?

Here are the tables (warning: poor attempt at ascii art... sorry!):

Configuration variables:
+---------------+--------+--------------+---------------------+----------------+
| Property      | Value  | Check in/out | Applies to          | Does what      |
+---------------+--------+--------------+---------------------+----------------+
| core.eol      | native | check out    | files marked text   | set EOL to OS  |
|               |        |              |                     |    native      |
+---------------+--------+--------------+---------------------+----------------+
| core.eol      | LF     | check out    | files marked text   | set EOL to LF  |
+---------------+--------+--------------+---------------------+----------------+
| core.eol      | CRLF   | check out    | files marked text   | set EOL to CRLF|
+---------------+--------+--------------+---------------------+----------------+
| core.autocrlf | true   | check out    | detected text files | set EOL to CRLF|
+---------------+--------+--------------+---------------------+----------------+
|               |        |              | other files         | check out as is|
+---------------+--------+--------------+---------------------+----------------+
|               |        | check in     | detected text files | LF in repo,    |
|               |        |              |                     |   checkin LF   |
|               |        |              |                     | CRLF in repo,  |
|               |        |              |                     |   checkin CRLF |
+---------------+--------+--------------+---------------------+----------------+
|               |        |              | other files         | check in as is |
+---------------+--------+--------------+---------------------+----------------+
| core.autocrlf | input  | check in     | detected text files | LF in repo,    |
|               |        |              |                     |   checkin LF   |
|               |        |              |                     | CRLF in repo,  |
|               |        |              |                     |   checkin CRLF |
+---------------+--------+--------------+---------------------+----------------+
|               |        |              | other files         | check in as is |
+---------------+--------+--------------+---------------------+----------------+
| core.autocrlf | unset  | nothing                                             |
+---------------+--------+--------------+---------------------+----------------+

Git attributes:
+-----------+------------+--------------+---------------------+----------------+
| Attribute | Value      | Check in/out | Applies to          | Does what      |
+-----------+------------+--------------+---------------------+----------------+
| text      | set        | check in     | matching files      | set EOL to LF  |
+-----------+------------+--------------+---------------------+----------------+
|           | unset      | check in     | matching files      | check in as is |
+-----------+------------+--------------+---------------------+----------------+
|           | auto       | check in     | matching detected   | set EOL to LF  |
|           |            |              |   text files        |                |
+-----------+------------+--------------+---------------------+----------------+
|           |            |              | matching non-text   | check in as is |
|           |            |              |    files            |                |
+-----------+------------+--------------+---------------------+----------------+
|           | unspecified| check in     | delegate to core.autocrlf            | 
+-----------+------------+--------------+---------------------+----------------+
| eol       | LF         | check out    | matching files      | set EOL to LF  |
+-----------+------------+--------------+---------------------+----------------+
|           | CRLF       | check out    | matching files      | set EOL to CRLF|
+-----------+------------+--------------+---------------------+----------------+

The open questions for me are:
  1) what is the actual text file detection algorithm?
  2) what is the autocrlf LF/CRLF detection algorithm?
  3) how does autocrlf handle mixed line endings? (either in the working copy or repo)

Thanks,
Stephen
