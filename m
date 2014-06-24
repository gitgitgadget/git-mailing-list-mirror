From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Git-status / preload_index() performance
Date: Wed, 25 Jun 2014 01:25:05 +0200
Message-ID: <53AA08D1.5080205@gmail.com>
References: <53AA0129.1080109@gmail.com> <1403651538.22828.4.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wza5R-0002VQ-Re
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 01:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbaFXXZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 19:25:07 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44226 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaFXXZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 19:25:06 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so1155974wgg.10
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vN+vzvLEeyNbNkwsgH8WBkIh/oOmRIojquw9xrL1CAw=;
        b=cngbRZI5drlQBxxUjmONls8fKLV6QyaF3MjxCFKN91FR7Q8yIvEofPO4ZUm4CbjaAW
         1h81yCas/2+rozTBq6j/SX7k7OUEC4Ih7wfsIEonOs3wHQXEjDxCI5x/hkYBOtqqbvn9
         eaIufutBRI6P2Fwh/aye/ucC3mpgOMz7S+X3OTzQcyWg7wQcYsnT25k+w4i34YG9EY0e
         JWAAQtdz9lb7ZjDnI+sMOl1QaISdQdSbkK4e2LGfvo4zp4PYtls+On9VfQhghsfFMKkY
         IYBMn1XkITkaLn/1W97Pxqjy+65xtBCct0R8kg3iCSRsHHc4stT4u8cnWTRrp9i4Vpwy
         I8Jw==
X-Received: by 10.194.119.228 with SMTP id kx4mr5253639wjb.108.1403652304831;
        Tue, 24 Jun 2014 16:25:04 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id na4sm47404402wic.21.2014.06.24.16.25.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 16:25:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1403651538.22828.4.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252426>

Am 25.06.2014 01:12, schrieb David Turner:
> On Wed, 2014-06-25 at 00:52 +0200, Karsten Blees wrote:
>> Even more time is spent unpacking the HEAD tree, even with hot cache (repacking with depth 10 reduces this to ~250ms, on SSD its just 7ms). Perhaps caching the HEAD tree in an index extension could help here?
> 
> This is approximately what the cache-tree extension does.  However, it's
> a bit broken.  I've been working on a fix, but slowly because my other
> work has taken me longer than expected.  You can see the effect of the
> cache-tree extension by doing git reset --hard HEAD; this temporarily
> restores that extension.
> 

Indeed:

01:32:35.965910 builtin/commit.c:1374   performance: 0.097505786 s: cmd_status:setup
...
01:32:36.047534 preload-index.c:129     performance: 0.081458337 s: read_index_preload
01:32:36.056204 read-cache.c:1226       performance: 0.008641527 s: refresh_index
01:32:36.059237 builtin/commit.c:1385   performance: 0.002997060 s: cmd_status:update_index
01:32:36.065163 wt-status.c:630         performance: 0.005732979 s: wt_status_collect_changes_worktree
01:32:36.072078 wt-status.c:638         performance: 0.006832976 s: wt_status_collect_changes_index
01:32:36.072150 wt-status.c:643         performance: 0.000000374 s: wt_status_collect_untracked
01:32:36.072211 trace.c:414             performance: 0.204069579 s: git command: 'git' 'status' '-s' '-uno'

Thanks
