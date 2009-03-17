From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 3/4] Cap the number of open files in the WindowCache
Date: Tue, 17 Mar 2009 23:59:32 +0100
Message-ID: <200903172359.32595.robin.rosenberg.lists@dewire.com>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org> <1237252570-8596-3-git-send-email-spearce@spearce.org> <1237252570-8596-4-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjiI0-00050m-9s
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 00:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbZCQW7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 18:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZCQW7l
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 18:59:41 -0400
Received: from mail.dewire.com ([83.140.172.130]:18811 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZCQW7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 18:59:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A1182138AD5E;
	Tue, 17 Mar 2009 23:59:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Syzn+lOuR0K; Tue, 17 Mar 2009 23:59:33 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 757BC138AD53;
	Tue, 17 Mar 2009 23:59:33 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1237252570-8596-4-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113534>

tisdag 17 mars 2009 02:16:09 skrev "Shawn O. Pearce" <spearce@spearce.org>:

> If we detect a file open failure while opening a pack we halve
> the number of permitted open files and try again, until we reach
> a lower bound of 16 open files.  Needing to go lower may indicate
> a file descriptor leak in the host application.
...
> +			TRY_OPEN: for (;;) {
> +				try {
> +					openFileCount++;
> +					releaseMemory();
> +					runClearedWindowQueue();
> +					wp.openCount = 1;
> +					wp.cacheOpen();
> +					break;
> +				} catch (IOException ioe) {
> +					openFileCount--;
> +					if ("Too many open files".equals(ioe.getMessage())
> +							&& maxFileCount > 16) {

The output of getMessage isn't that simple to interpret. Here it is filename+" (Too many files open)",
and on other platforms it is probably something else. This goes for the message part of most exceptions
thrown from platform specific code like file i/o socket i/o etc. The type of exception is a FileNotFoundException,
btw.

I wonder whether  your code works on any platform.
