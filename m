Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF931F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbcFUKkG (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:40:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:59544 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcFUKj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:39:59 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7Gj8-1bd9RM3LVO-00wzVD; Tue, 21 Jun 2016 12:39:38
 +0200
Date:	Tue, 21 Jun 2016 12:39:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] log-tree: respect diffopt's configured output
 file stream
In-Reply-To: <alpine.DEB.2.20.1606210937440.22630@virtualbox>
Message-ID: <alpine.DEB.2.20.1606211236040.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de> <babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de> <xmqqwplju74a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606210920510.22630@virtualbox> <alpine.DEB.2.20.1606210937440.22630@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:othH8IAe9E5iZ68NC6X562Jrf0O8NrqcXlpGhAYdLeCrTfI2MTt
 9rCm/bCZRG+aE0G6ZIoaadR68aQfGN3N3wPDV2VgxYp/Z+xtzmqSC8Sa0fX+ddOReW4kN0G
 3093A02TDns202ePsB7+gC7C+wOml+qqQC5aBZBUWhyU6PjbpAhxsk9UVEjKj2glHrO3pyr
 W03e6AvYzSKA7b209METQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:o7zNjSw6YJ0=:/A05KHEK3blIbqwVTn/DvH
 +8QiRw6rFClB4+i2Ju0F3hsxER7JohuZ6He4WALgYEefTgRNCmci0omxTRQCqdInTdOtdtKke
 nQo/XAYLpyLxbMlcMx9fdtvbhzqxszguIeSJVeL7kd/Cl3g9Erhm8ObAaWKO60Qbv3WfkfSUA
 kOrZUnq6or0/3ePJbj1tPP8AfglEMw0QzvFbDfwVlJrxB83gQD7JH3Wu74JoUFk3igwIrTwcQ
 mz7iNuAW9L/roFyl6Joot7aLRfkY18a9mIiuHNegOOEvhy2XGUf+8iUFeyZIwQF/SLmcGsOe8
 OWkCQLf4s8M781rcLbJyroT81ZvOcdb4uIhlh7oWu7By4bny6I6Dpb7SpRhGiwYOzk6k9HZKK
 U8V3NDJ0ObxB9qKy9xw3C5yY31E/x7nP/L41R/Ka7Xn0DSwPdkJQYnK/iLchE8GybhBxektQa
 mxCqkx+zw+4Mxk7ln2lbeUoJ9EQnzrpsedLjvdNruzq4n5V+Q82lZ+lS6Nt+bFM0kbN4eSM4e
 X/+U2rNKxTfqSiAH3xxd8c+NRzjyAYYwE+Ah15Gc+5Qw9mM3GeWJJw8W2enwTKBbYuCOZvv7g
 M9x8HCqvcPrhyocAQihhm2fKmh5wf0cRwCk7l4CG39OamhMw7tI6d+Ea8bgfpBDtpkkP8/8PC
 weOv6vWTykeMw1lZ+r7ny3zQ0AbshRzGrhjDWgV7BBOyJhoTpQPUQTD0Ai+AZMXx1ZPWHKHWJ
 3EAsfigPof02DBslva2XNBEx7PJk0Pg/ToPA1kWcpn5kHPEaI8w5j2rFVIRPSelYdtnw8vMAG
 CeeH/s1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, 21 Jun 2016, Johannes Schindelin wrote:

> On Tue, 21 Jun 2016, Johannes Schindelin wrote:
> 
> > Expect v3 in a moment.
> 
> I am sorry. The regression test suite just sounded red alert. So: do not
> expect v3 in a moment, but later today.

So making maybe_flush_or_die() uncovered a problem with the builtin am: it
called log_tree_commit() after setting diffopt.file *and*
diffopt.close_file. The latter forced diff_flush() to close the file, and
log_tree_commit() happily tried to flush() the same file stream. In my
setup, this triggered a segmentation fault which was really hard to debug
because it happened in a Git subprocess that expected input from stdin
(and therefore my go-to debugging method to fire up gdb was a bit
useless).

In the end, it not only added two new patches to the patch series, but
also opened a big rabbit hole: builtin/am.c could use quite some error
checking, I guess... Now I wish I hadn't seen it...

Well, I just sent v3 of the series.

Ciao,
Dscho
