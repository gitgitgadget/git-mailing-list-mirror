From: Wincent Colaiuta <win@wincent.com>
Subject: "git add -i" with path gives "Argument list too long"
Date: Mon, 4 Jan 2010 19:43:10 +0100
Message-ID: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRs7s-0005nJ-N3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 19:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab0ADS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 13:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724Ab0ADS5w
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 13:57:52 -0500
Received: from outmail137082.authsmtp.co.uk ([62.13.137.82]:62171 "EHLO
	outmail137082.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753528Ab0ADS5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 13:57:51 -0500
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2010 13:57:51 EST
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt4.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o04IhJek099673
	for <git@vger.kernel.org>; Mon, 4 Jan 2010 18:43:19 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o04IhFHD030680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 4 Jan 2010 18:43:16 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o04IhBCe032132
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 4 Jan 2010 13:43:14 -0500
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 0586487e-f961-11de-ab46-001185d377ca
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha Dh4fBRVVLUBPVglL NEteaF1JP0tEGRZ7 UjgUWVRVUE1wUWlx aABQa0tfYkNQXQZv TklAQExTEgR3Axke B1BBUh0LL3M+DH5z ZUBqXj5fXkJ6O0Z4 SkhQHWpTeDFpbmEC UUEMIh4FIgdMYx9F a1F3UScOZmJUNzRy EA4vdzk9MX0aKW4d XQARLRoKSFoLVjE9 WR0ZVX8GB0IYQig1 M1QiK0UAVFoWNQ02 Nl0uEzrg
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136135>

Just ran "git add -i <path>" with "<path>" pointing to a subdirectory  
which happens to have a bunch of files in it (about 7k) and it barfed  
thusly:

   Can't exec "git": Argument list too long at /usr/local/libexec/git- 
core/git-add--interactive line 158.
   Died at /usr/local/libexec/git-core/git-add--interactive line 158.

I see that what it's trying to do under the hood is:

   git diff-index --cached --numstat --summary HEAD -- <7,000+ paths...>

Sure, we could divide the paths into smaller groups, run multiple  
invocations of "git diff-index", and concatenate the results. But it  
would be nicer if there was some other way that we could get at the  
same information without having to pass 7,000 paths explicitly on the  
command line; is there any which I am overlooking?

The enormous file list is the result of passing <path> into "git ls- 
files -- <path>". Would it be worth:

- either, modifying "git diff-index" to accept a list of paths over  
stdin so that we could at least pipe the output from "git ls-files"  
into "git diff-index"

- or, preferably, teach "git diff index" to recurse into directories  
rather than expect a list of paths-of-blobs (possibly with a command  
line switch to activate the behaviour if it were deemed a dangerous  
default)

This is one piece of plumbing that I've never dabbled with, so forgive  
me if my questions are a little dumb.

Cheers,
Wincent
