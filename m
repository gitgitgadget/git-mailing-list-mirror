From: Luke Lu <git@vicaya.com>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 14:55:53 -0800
Message-ID: <903B0E5A-32E2-4029-90C1-8C227BEDD03D@vicaya.com>
References: <20071203191143.GB17671@steel.home> <m3lk8bv8du.fsf@roke.D-201>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKDJ-0003PT-VU
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXLCW4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXLCW4M
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:56:12 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:51709 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXLCW4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:56:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2874623rvb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=+9UZ/wuAQflHls3ToFoSjNG96+D8qnNqoVZv5ET7k7E=;
        b=Q6CTKG23XffWC++Zx/SdJoYnzLFa3Ao/sif1qGRnF7xD/MOUYzVaX+ERHnxnQGqp1RyEdyzKI1WpzYnQGmrjzcpmcPiapzDkqUaOcD8xaV0x1YnsV+CY6YkvxXg9j5gmkqRnF4Q9uDSFASOVXftWYlKPRyBIUEso0BkDBkmNqWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=d8v1OsUyPOOFoLUo0bsVey93VImEC6074CFkxcYdnOm0BZumbLXrc2tn7NscYk9QUCRiRr7sn+gly1fJlyIOQIfq1m+O0oU8+H1xD6wpC0FP8bnp9cuvDD82P4A9OZIz2KRpwIqSo1blu0MSk+Dsa2UY2pDgSwO0hHe/M8gU3f4=
Received: by 10.140.126.10 with SMTP id y10mr533787rvc.1196722569612;
        Mon, 03 Dec 2007 14:56:09 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id b21sm308121rvf.2007.12.03.14.56.03
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 14:56:07 -0800 (PST)
In-Reply-To: <m3lk8bv8du.fsf@roke.D-201>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66971>


On Dec 3, 2007, at 12:19 PM, Jakub Narebski wrote:

> Perhaps simplier, but isn't it slower?

Actually it's faster on modern cpu with deep pipelines. The following  
is simple test on my macbookpro (repeated 3 times and picked lowest  
one):

$ time ./crudtest 1000000000
old crud...
real    0m0.856s
user    0m0.839s
sys     0m0.011s
$ time ./crudtest 1000000000 simple
new crud...
real    0m0.431s
user    0m0.421s
sys     0m0.007s

Note: it's compiled with gcc -O2. -O3 gives the same timing; -O:  
simple crud has the same timing while the old crud is 10x slower; -O0  
(off): the simple code is 50% slower than old crud (note: 10x less  
iterations):

$ time ./crudtest0 100000000
old crud...
real    0m0.659s
user    0m0.638s
sys     0m0.008s
$ time ./crudtest0 100000000 simple
new crud...
real    0m1.175s
user    0m1.149s
sys     0m0.014s

Since the default CFLAGS in git Makefile has -O2, the simple/new code  
is faster by default.

__Luke
