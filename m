From: "Heald, Mike" <mike.heald@hp.com>
Subject: Deadlock during remote update
Date: Fri, 27 Feb 2015 11:03:18 +0000
Message-ID: <311995D1237EC0498D6D8FAFA73D6F458F1B67@G9W0762.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 12:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRIic-0001hq-TE
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 12:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbB0LEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 06:04:23 -0500
Received: from g4t3427.houston.hp.com ([15.201.208.55]:55002 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbB0LEW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 06:04:22 -0500
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3427.houston.hp.com (Postfix) with ESMTPS id 1FF9E2D6
	for <git@vger.kernel.org>; Fri, 27 Feb 2015 11:04:21 +0000 (UTC)
Received: from G4W6306.americas.hpqcorp.net (16.210.26.231) by
 G4W6310.americas.hpqcorp.net (16.210.26.217) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Fri, 27 Feb 2015 11:03:19 +0000
Received: from G9W0762.americas.hpqcorp.net ([169.254.10.35]) by
 G4W6306.americas.hpqcorp.net ([16.210.26.231]) with mapi id 14.03.0169.001;
 Fri, 27 Feb 2015 11:03:19 +0000
Thread-Topic: Deadlock during remote update
Thread-Index: AdBSfP3rbk/FpxODSku96cuqg/GJUQ==
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.216.65.178]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264493>

Hi,

We have a cron job that runs remote update on a number of repositories. Sometimes, the processes deadlock and we have to go -TERM them. Here's a breakdown of what state the processes end up in when the deadlock happens, from one of our production systems yesterday:

31629 git --git-dir=/var/lib/jeepyb/openstack/nova/.git --work-tree=/var/lib/jeepyb/openstack/nova remote update --prune
    wait4'ing for 31630
31630 git fetch --prune --multiple --all
    wait4'ing for 31637
31637 git fetch --append --prune upstream
    waiting for read from pipe:[170381707] (fd 25)
31638 git-remote-https upstream https://git.openstack.org/openstack/nova
    has pipe:[170381707] (fd 1), waiting for read from pipe:[170384472]
31642 git fetch-pack --stateless-rpc --lock-pack --include-tag --thin --no-progress https://git.openstack.org/openstack/nova/  efs/heads/master
    has pipe:[170384472] (fd 1), waiting for read from pipe:[170384471] (fd 0) which fd 7 on 31638

31638 and 31642 are both waiting to read from a pipe that the other has, and isn't writing to.

This is git version 1.7.9.5, OS is ubuntu precise.

Any ideas, or any way I can get more useful info?

Thanks,
Mike
