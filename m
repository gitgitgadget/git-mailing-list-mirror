From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] grep: Fix race condition in delta_base_cache
Date: Wed, 31 Aug 2011 21:13:28 +0200
Message-ID: <4E5E87D8.3080108@morey-chaisemartin.com>
References: <4E5CE982.7080200@morey-chaisemartin.com> <20110831015936.GB2519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 23:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyrzq-0003Pc-DA
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 23:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab1HaVGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 17:06:49 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:58529 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429Ab1HaVGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 17:06:48 -0400
X-Greylist: delayed 104095 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Aug 2011 17:06:48 EDT
Received: from mail174.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id AA8841000F42
	for <git@vger.kernel.org>; Wed, 31 Aug 2011 21:13:45 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 31 Aug 2011 21:13:30 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 31 Aug 2011 21:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110816 Thunderbird/6.0
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <20110831015936.GB2519@sigill.intra.peff.net>
X-Ovh-Tracer-Id: 9788573790500413432
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.500001/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -130
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeftddruddtucetggdotefuucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenucculddquddttddmnehthhgvuchprhhosghlvghmucdlqdeftddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180506>

On 08/31/2011 03:59 AM, Jeff King wrote:
> I notice there are some other code paths that end up in xmalloc without
> locking, too (e.g., load_file, and some strbuf_* calls). Don't those
> need locking, too, as malloc may try to release packfile memory?
> 
> builtin/pack-objects.c dealt with this already by setting a new
> "try_to_free" routine that locks[1], which we should also do. It
> probably comes up less frequently, because it only happens when we're
> under memory pressure.
> 
> -Peff
> 
> [1] Actually, it looks like the "try_to_free" routine starts as nothing,
>     and then add_packed_git sets it lazily to try_to_free_pack_memory.
>     But what builtin/pack-objects tries to do is overwrite that with a
>     version of try_to_free_pack_memory that does locking. So it's
>     possible that we would not have read any packed objects while
>     setting up the threads, and add_packed_git will overwrite our
>     careful, locking version of try_to_free_pack_memory.
> 
>     I _think_ pack-objects is probably OK, because it will have already
>     done the complete "counting objects" phase, which would look in any
>     packs. But it may be harder for grep.
> 

After some more looking around, I'd say the best way to fix this is provide a lock to the try_to_free function from sha1_file
and provide access to this lock for pack-objects and grep to replace respectively the read_mutex and read_sha1_mutex.
So we can simplify the problem by having a single lock to avoid all the cache/free issues (and reusable elsewhere if needed in the future), whether it's shared through direct access or API (I'm not sure what's git policy about that).
And this way, there is no need to duplicate what pack-objects is achieving and it gives some peace of mind about the fact that the try_to _free function won't be overwritten in our backs.

Nicolas Morey-Chaisemartin
