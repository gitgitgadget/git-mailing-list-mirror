From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] grep: Fix race condition in delta_base_cache
Date: Wed, 31 Aug 2011 08:32:50 +0200
Message-ID: <4E5DD592.5090608@morey-chaisemartin.com>
References: <4E5CE982.7080200@morey-chaisemartin.com> <20110831015936.GB2519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 08:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyeM9-0002uO-3v
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 08:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab1HaGc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 02:32:56 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:50290 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753750Ab1HaGcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 02:32:55 -0400
X-Greylist: delayed 58262 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Aug 2011 02:32:55 EDT
Received: from mail174.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id EB97C100800F
	for <git@vger.kernel.org>; Wed, 31 Aug 2011 08:33:07 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 31 Aug 2011 08:32:53 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 31 Aug 2011 08:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110816 Thunderbird/6.0
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <20110831015936.GB2519@sigill.intra.peff.net>
X-Ovh-Tracer-Id: 15389644352611147768
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.506749/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeftddrtdekucetggdotefuucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenucculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180457>

On 08/31/2011 03:59 AM, Jeff King wrote:
> 
> I notice there are some other code paths that end up in xmalloc without
> locking, too (e.g., load_file, and some strbuf_* calls). Don't those
> need locking, too, as malloc may try to release packfile memory?
> 
After some consideration I think they do.
Grep threads definitly get the try_to_free  function registered while the main one does at least some xreallock out of sha1_file.c (so not owning the lock).
I guess it requires the same kind of lock pack-objects.c uses (meaning we need to set the try_to_free function in grep.c too).

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

I'm not expert enough in git pathways to be sure about pack_objects but I agree it looks "risky".
Maybe add_packed_git should check whether there already is a free routine (other than do_nothing) instead of simply setting it up the first time.

Nicolas Morey-Chaisemartin
