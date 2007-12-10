From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 01:19:26 -0500
Message-ID: <9e4733910712092219kd86e576k33b11c93179f6475@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
	 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
	 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
	 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
	 <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1c04-0007zw-GY
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbXLJGT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 01:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXLJGT1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 01:19:27 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:46288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbXLJGT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 01:19:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3152178wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 22:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3UWInVynVvrAkeYU5/EZwRHkqMKD2w/OTxA9x3a2Ft4=;
        b=x8+UGs0nkTE8kolWSp1Krp6lKzTwsX4eRmFyCRWob5/FnTc/HotSA5wVix4DVaCqky4LX30HYzL5dIpFbyv3ZB4ahxmn7db4WAB65GQjcB3QMexv0l2MmpekZ0tqXZiLreZ2nPjSn6Wo0Y+/jLe7z5A0BOg6dEhprDEE6hb7TTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Er0MaAj5414Roy6YkF8l2zYlP1uI7zC/oPQDaiBsaRH/S4RaUo1jGV42K8zfYrxkrROV8TOKPWchLW3NQpeMeKMKUSN9MWMRhQ9NV3Z4eKCK918Rzf64OJAMPssXsF/qzo1c9+7TdQHusQEsqFG9zKaXahTGYIpx503GKAJwkb0=
Received: by 10.115.79.1 with SMTP id g1mr188556wal.1197267566241;
        Sun, 09 Dec 2007 22:19:26 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 22:19:26 -0800 (PST)
In-Reply-To: <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67683>

It seems to be caused by looping over those runs of 100,000 identical
hash entries.
5091699 24.6407 :                       for (entry = index->hash[i];
entry < index->hash[i+1]; entry++) {
5301791 25.6575 :                               const unsigned char
*ref = entry->ptr;



228772  1.1071 :        while (data < top) {
223646  1.0823 :                if (msize < 4096) {
               :                        struct index_entry *entry;
  5862  0.0284 :                        val ^= U[data[-RABIN_WINDOW]];
753004  3.6441 :                        val = ((val << 8) | *data) ^
T[val >> RABIN_SHIFT];
1232556  5.9648 :                       i = val & index->hash_mask;
5091699 24.6407 :                       for (entry = index->hash[i];
entry < index->hash[i+1]; entry++) {
5301791 25.6575 :                               const unsigned char
*ref = entry->ptr;
               :                                const unsigned char *src = data;
 25919  0.1254 :                                unsigned int ref_size
= ref_top - ref;
740077  3.5815 :                                if (entry->val != val)
               :                                        continue;
   331  0.0016 :                                if (ref_size > top - src)
 83804  0.4056 :                                        ref_size = top - src;
 25059  0.1213 :                                if (ref_size <= msize)
               :                                        break;
1269621  6.1442 :                               while (ref_size-- &&
*src++ == *ref)
 42122  0.2038 :                                        ref++;
 14362  0.0695 :                                if (msize < ref - entry->ptr) {
               :                                        /* this is our
best match so far */
 10452  0.0506 :                                        msize = ref -
entry->ptr;
  6882  0.0333 :                                        moff =
entry->ptr - ref_data;
  6382  0.0309 :                                        if (msize >=
4096) /* good enough */
               :                                                break;
               :                                }
               :                        }


-- 
Jon Smirl
jonsmirl@gmail.com
