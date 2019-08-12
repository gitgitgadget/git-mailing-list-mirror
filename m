Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515E41F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfHLNsN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Aug 2019 09:48:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42676 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHLNsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 09:48:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7CDmAFi047174
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 09:48:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Gregory Szorc'" <gregory.szorc@gmail.com>, <git@vger.kernel.org>
References: <qimq0i$49gn$1@blaine.gmane.org>
In-Reply-To: <qimq0i$49gn$1@blaine.gmane.org>
Subject: RE: Non-robust lock files in containers can lead to repo corruption
Date:   Mon, 12 Aug 2019 09:48:04 -0400
Message-ID: <003901d55114$9428df40$bc7a9dc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHeDVg5r33thhiqTgwgNYjD6Rz7HKbmDPdw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 10, 2019 12:06 PM, Gregory Szorc wrote:
> I tracked down a source of Git corrupting repositories to lock file design not
> being robust when containers / PID namespaces are present.
> 
> In my case, the corruption stemmed from premature release of the `git gc`
> lock in the gc.pid file. But since the lock file code for that file is in gc.c, there
> could be other lock files in Git affected by the same design limitation as well.
> 
> The lock design of gc.pid stores the current hostname and PID of the locking
> process in the file. If another process comes along and its hostname matches
> the stored hostname, it checks to see if the listed PID exists. If the PID is
> missing, it assumes the lock is stale and releases the lock.
> 
> A limitation with this approach is it isn't robust in the presence of containers
> / PID namespaces. In containers, it is common for the hostname to match
> the container host's hostname. Or the hostname will be static string. In
> Kubernetes, all containers within a pod share the same hostname. Containers
> (almost always) run in separate PID namespaces, so PIDs from outside the
> container aren't visible to the container itself.
> This means that if e.g. 2 `git gc` processes are running with the same
> hostname in separate containers / PID namespaces, Git could prematurely
> release the lock file because it thinks the "other" PID is dead and repo
> corruption could ensue due to the 2 `git gc` processes racing with each other.
> 
> The on-disk format of lock files obviously needs to be backwards compatible
> with older clients. One backwards compatible solution is to append
> something to the hostname to disambiguate containers / PID namespaces.
> Mercurial appends the current PID namespace identifier to the hostname [1]
> and my experience is that this is sufficient to mitigate the issue. It is possible
> more robust solutions are achievable.

While I like the idea personally, many platforms, including NonStop (TNS/E),  do not support pid namespaces. In particular setns(2) may not be implemented. Please make sure that any changes detect this condition properly and omit the use of namespaces.

Regards,
Randall


