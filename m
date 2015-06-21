From: Charles Bailey <charles@hashpling.org>
Subject: Fast enumeration of objects
Date: Sun, 21 Jun 2015 20:20:30 +0100
Message-ID: <1434914431-7745-1-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 21:21:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6kni-0007ii-5j
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 21:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbFUTUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 15:20:53 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:43178 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbFUTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 15:20:41 -0400
Received: from hashpling.plus.com ([212.159.69.125]:53913)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z6knH-0003Vs-RS; Sun, 21 Jun 2015 20:20:39 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434705059-2793-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272281>

This is a re-casting of my previous filter-objects command but without
any of the filtering so it is now just "list-all-objects".

I have retained the "--verbose" option which outputs the same format as
the default "cat-file --batch-check" as it provides a useful performance
gain to filtering though "cat-file" if this basic information is all
that is needed.

The motivating use case is to enable a script to quickly scan a large
number of repositories for any large objects.

I performed some test timings of some different commands on a clone of
the Linux kernel which was completely packed.

	$ time git rev-list --all --objects |
		cut -d" " -f1 |
		git cat-file --batch-check |
		awk '{if ($3 >= 512000) { print $1 }}' |
		wc -l
	958

	real    0m30.823s
	user    0m41.904s
	sys     0m7.728s

list-all-objects gives a significant improvement:

	$ time git list-all-objects |
		git cat-file --batch-check |
		awk '{if ($3 >= 512000) { print $1 }}' |
		wc -l
	958

	real    0m9.585s
	user    0m10.820s
	sys     0m4.960s

skipping the cat-filter filter is a lesser but still significant
improvement:

	$ time git list-all-objects -v |
		awk '{if ($3 >= 512000) { print $1 }}' |
		wc -l
	958

	real    0m5.637s
	user    0m6.652s
	sys     0m0.156s

The old filter-objects could do the size filter a little be faster, but
not by much:

	$ time git filter-objects --min-size=500k |
		wc -l
	958

	real    0m4.564s
	user    0m4.496s
	sys     0m0.064s
