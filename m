From: David Miller <davem@davemloft.net>
Subject: end of file newline regression
Date: Sun, 16 Dec 2007 15:54:13 -0800 (PST)
Message-ID: <20071216.155413.165709543.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Dec_16_15_54_13_2007_810)--"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 00:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J43Jp-0001Xo-9I
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 00:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbXLPXyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 18:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757195AbXLPXyZ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 18:54:25 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60167
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751762AbXLPXyY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2007 18:54:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id A00273740A7
	for <git@vger.kernel.org>; Sun, 16 Dec 2007 15:54:13 -0800 (PST)
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68503>

----Next_Part(Sun_Dec_16_15_54_13_2007_810)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I've stumbled into a problem with current mainline.

I have this changeset that I can't get GIT to properly
generate diffs for.  It always give me:

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 4440532..096974b 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -177,5 +177,4 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			BUG();
 
 		if (unlikely(memcmp(esp->auth.work_icv, sum, alen))) {
-			x->stats.integrity_failed++;
-			ret = -EINVAL;
\ No newline at end of file
+			ret = -EBADMSG;
\ No newline at end of file

No matter what I do, 1.5.3.7 doesn't do this.

The file does have a newline at the end.

Here are files you can hopefully use to reproduce:

1) esp6.c
2) the patch, one that can be applied properly

You should be able to put that esp6.c into an empty
git repo, apply the patch in #2, then run "git diff >diff"
using mainline to see the problem.


----Next_Part(Sun_Dec_16_15_54_13_2007_810)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="esp6.c"

/*
 * Copyright (C)2002 USAGI/WIDE Project
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Authors
 *
 *	Mitsuru KANDA @USAGI       : IPv6 Support
 * 	Kazunori MIYAZAWA @USAGI   :
 * 	Kunihiro Ishiguro <kunihiro@ipinfusion.com>
 *
 * 	This file is derived from net/ipv4/esp.c
 */

#include <linux/err.h>
#include <linux/module.h>
#include <net/ip.h>
#include <net/xfrm.h>
#include <net/esp.h>
#include <linux/scatterlist.h>
#include <linux/crypto.h>
#include <linux/kernel.h>
#include <linux/pfkeyv2.h>
#include <linux/random.h>
#include <linux/spinlock.h>
#include <net/icmp.h>
#include <net/ipv6.h>
#include <net/protocol.h>
#include <linux/icmpv6.h>

static int esp6_output(struct xfrm_state *x, struct sk_buff *skb)
{
	int err;
	struct ip_esp_hdr *esph;
	struct crypto_blkcipher *tfm;
	struct blkcipher_desc desc;
	struct sk_buff *trailer;
	int blksize;
	int clen;
	int alen;
	int nfrags;
	u8 *tail;
	struct esp_data *esp = x->data;

	/* skb is pure payload to encrypt */
	err = -ENOMEM;

	/* Round to block size */
	clen = skb->len;

	alen = esp->auth.icv_trunc_len;
	tfm = esp->conf.tfm;
	desc.tfm = tfm;
	desc.flags = 0;
	blksize = ALIGN(crypto_blkcipher_blocksize(tfm), 4);
	clen = ALIGN(clen + 2, blksize);
	if (esp->conf.padlen)
		clen = ALIGN(clen, esp->conf.padlen);

	if ((nfrags = skb_cow_data(skb, clen-skb->len+alen, &trailer)) < 0) {
		goto error;
	}

	/* Fill padding... */
	tail = skb_tail_pointer(trailer);
	do {
		int i;
		for (i=0; i<clen-skb->len - 2; i++)
			tail[i] = i + 1;
	} while (0);
	tail[clen-skb->len - 2] = (clen - skb->len) - 2;
	pskb_put(skb, trailer, clen - skb->len);

	skb_push(skb, -skb_network_offset(skb));
	esph = ip_esp_hdr(skb);
	*(skb_tail_pointer(trailer) - 1) = *skb_mac_header(skb);
	*skb_mac_header(skb) = IPPROTO_ESP;

	esph->spi = x->id.spi;
	esph->seq_no = htonl(XFRM_SKB_CB(skb)->seq);

	spin_lock_bh(&x->lock);

	if (esp->conf.ivlen) {
		if (unlikely(!esp->conf.ivinitted)) {
			get_random_bytes(esp->conf.ivec, esp->conf.ivlen);
			esp->conf.ivinitted = 1;
		}
		crypto_blkcipher_set_iv(tfm, esp->conf.ivec, esp->conf.ivlen);
	}

	do {
		struct scatterlist *sg = &esp->sgbuf[0];

		if (unlikely(nfrags > ESP_NUM_FAST_SG)) {
			sg = kmalloc(sizeof(struct scatterlist)*nfrags, GFP_ATOMIC);
			if (!sg)
				goto unlock;
		}
		sg_init_table(sg, nfrags);
		skb_to_sgvec(skb, sg,
			     esph->enc_data +
			     esp->conf.ivlen -
			     skb->data, clen);
		err = crypto_blkcipher_encrypt(&desc, sg, sg, clen);
		if (unlikely(sg != &esp->sgbuf[0]))
			kfree(sg);
	} while (0);

	if (unlikely(err))
		goto unlock;

	if (esp->conf.ivlen) {
		memcpy(esph->enc_data, esp->conf.ivec, esp->conf.ivlen);
		crypto_blkcipher_get_iv(tfm, esp->conf.ivec, esp->conf.ivlen);
	}

	if (esp->auth.icv_full_len) {
		err = esp_mac_digest(esp, skb, (u8 *)esph - skb->data,
				     sizeof(*esph) + esp->conf.ivlen + clen);
		memcpy(pskb_put(skb, trailer, alen), esp->auth.work_icv, alen);
	}

unlock:
	spin_unlock_bh(&x->lock);

error:
	return err;
}

static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
{
	struct ipv6hdr *iph;
	struct ip_esp_hdr *esph;
	struct esp_data *esp = x->data;
	struct crypto_blkcipher *tfm = esp->conf.tfm;
	struct blkcipher_desc desc = { .tfm = tfm };
	struct sk_buff *trailer;
	int blksize = ALIGN(crypto_blkcipher_blocksize(tfm), 4);
	int alen = esp->auth.icv_trunc_len;
	int elen = skb->len - sizeof(*esph) - esp->conf.ivlen - alen;
	int hdr_len = skb_network_header_len(skb);
	int nfrags;
	int ret = 0;

	if (!pskb_may_pull(skb, sizeof(*esph))) {
		ret = -EINVAL;
		goto out;
	}

	if (elen <= 0 || (elen & (blksize-1))) {
		ret = -EINVAL;
		goto out;
	}

	/* If integrity check is required, do this. */
	if (esp->auth.icv_full_len) {
		u8 sum[alen];

		ret = esp_mac_digest(esp, skb, 0, skb->len - alen);
		if (ret)
			goto out;

		if (skb_copy_bits(skb, skb->len - alen, sum, alen))
			BUG();

		if (unlikely(memcmp(esp->auth.work_icv, sum, alen))) {
			x->stats.integrity_failed++;
			ret = -EINVAL;
			goto out;
		}
	}

	if ((nfrags = skb_cow_data(skb, 0, &trailer)) < 0) {
		ret = -EINVAL;
		goto out;
	}

	skb->ip_summed = CHECKSUM_NONE;

	esph = (struct ip_esp_hdr *)skb->data;
	iph = ipv6_hdr(skb);

	/* Get ivec. This can be wrong, check against another impls. */
	if (esp->conf.ivlen)
		crypto_blkcipher_set_iv(tfm, esph->enc_data, esp->conf.ivlen);

	{
		u8 nexthdr[2];
		struct scatterlist *sg = &esp->sgbuf[0];
		u8 padlen;

		if (unlikely(nfrags > ESP_NUM_FAST_SG)) {
			sg = kmalloc(sizeof(struct scatterlist)*nfrags, GFP_ATOMIC);
			if (!sg) {
				ret = -ENOMEM;
				goto out;
			}
		}
		sg_init_table(sg, nfrags);
		skb_to_sgvec(skb, sg,
			     sizeof(*esph) + esp->conf.ivlen,
			     elen);
		ret = crypto_blkcipher_decrypt(&desc, sg, sg, elen);
		if (unlikely(sg != &esp->sgbuf[0]))
			kfree(sg);
		if (unlikely(ret))
			goto out;

		if (skb_copy_bits(skb, skb->len-alen-2, nexthdr, 2))
			BUG();

		padlen = nexthdr[0];
		if (padlen+2 >= elen) {
			LIMIT_NETDEBUG(KERN_WARNING "ipsec esp packet is garbage padlen=%d, elen=%d\n", padlen+2, elen);
			ret = -EINVAL;
			goto out;
		}
		/* ... check padding bits here. Silly. :-) */

		/* RFC4303: Drop dummy packets without any error */
		if (nexthdr[1] == IPPROTO_NONE) {
			ret = -EINVAL;
			goto out;
		}

		pskb_trim(skb, skb->len - alen - padlen - 2);
		ret = nexthdr[1];
	}

	__skb_pull(skb, sizeof(*esph) + esp->conf.ivlen);
	skb_set_transport_header(skb, -hdr_len);
out:
	return ret;
}

static u32 esp6_get_mtu(struct xfrm_state *x, int mtu)
{
	struct esp_data *esp = x->data;
	u32 blksize = ALIGN(crypto_blkcipher_blocksize(esp->conf.tfm), 4);
	u32 align = max_t(u32, blksize, esp->conf.padlen);
	u32 rem;

	mtu -= x->props.header_len + esp->auth.icv_trunc_len;
	rem = mtu & (align - 1);
	mtu &= ~(align - 1);

	if (x->props.mode != XFRM_MODE_TUNNEL) {
		u32 padsize = ((blksize - 1) & 7) + 1;
		mtu -= blksize - padsize;
		mtu += min_t(u32, blksize - padsize, rem);
	}

	return mtu - 2;
}

static void esp6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
		     int type, int code, int offset, __be32 info)
{
	struct ipv6hdr *iph = (struct ipv6hdr*)skb->data;
	struct ip_esp_hdr *esph = (struct ip_esp_hdr *)(skb->data + offset);
	struct xfrm_state *x;

	if (type != ICMPV6_DEST_UNREACH &&
	    type != ICMPV6_PKT_TOOBIG)
		return;

	x = xfrm_state_lookup((xfrm_address_t *)&iph->daddr, esph->spi, IPPROTO_ESP, AF_INET6);
	if (!x)
		return;
	printk(KERN_DEBUG "pmtu discovery on SA ESP/%08x/" NIP6_FMT "\n",
			ntohl(esph->spi), NIP6(iph->daddr));
	xfrm_state_put(x);
}

static void esp6_destroy(struct xfrm_state *x)
{
	struct esp_data *esp = x->data;

	if (!esp)
		return;

	crypto_free_blkcipher(esp->conf.tfm);
	esp->conf.tfm = NULL;
	kfree(esp->conf.ivec);
	esp->conf.ivec = NULL;
	crypto_free_hash(esp->auth.tfm);
	esp->auth.tfm = NULL;
	kfree(esp->auth.work_icv);
	esp->auth.work_icv = NULL;
	kfree(esp);
}

static int esp6_init_state(struct xfrm_state *x)
{
	struct esp_data *esp = NULL;
	struct crypto_blkcipher *tfm;

	if (x->ealg == NULL)
		goto error;

	if (x->encap)
		goto error;

	esp = kzalloc(sizeof(*esp), GFP_KERNEL);
	if (esp == NULL)
		return -ENOMEM;

	if (x->aalg) {
		struct xfrm_algo_desc *aalg_desc;
		struct crypto_hash *hash;

		hash = crypto_alloc_hash(x->aalg->alg_name, 0,
					 CRYPTO_ALG_ASYNC);
		if (IS_ERR(hash))
			goto error;

		esp->auth.tfm = hash;
		if (crypto_hash_setkey(hash, x->aalg->alg_key,
				       (x->aalg->alg_key_len + 7) / 8))
			goto error;

		aalg_desc = xfrm_aalg_get_byname(x->aalg->alg_name, 0);
		BUG_ON(!aalg_desc);

		if (aalg_desc->uinfo.auth.icv_fullbits/8 !=
		    crypto_hash_digestsize(hash)) {
			NETDEBUG(KERN_INFO "ESP: %s digestsize %u != %hu\n",
				 x->aalg->alg_name,
				 crypto_hash_digestsize(hash),
				 aalg_desc->uinfo.auth.icv_fullbits/8);
			goto error;
		}

		esp->auth.icv_full_len = aalg_desc->uinfo.auth.icv_fullbits/8;
		esp->auth.icv_trunc_len = aalg_desc->uinfo.auth.icv_truncbits/8;

		esp->auth.work_icv = kmalloc(esp->auth.icv_full_len, GFP_KERNEL);
		if (!esp->auth.work_icv)
			goto error;
	}
	tfm = crypto_alloc_blkcipher(x->ealg->alg_name, 0, CRYPTO_ALG_ASYNC);
	if (IS_ERR(tfm))
		goto error;
	esp->conf.tfm = tfm;
	esp->conf.ivlen = crypto_blkcipher_ivsize(tfm);
	esp->conf.padlen = 0;
	if (esp->conf.ivlen) {
		esp->conf.ivec = kmalloc(esp->conf.ivlen, GFP_KERNEL);
		if (unlikely(esp->conf.ivec == NULL))
			goto error;
		esp->conf.ivinitted = 0;
	}
	if (crypto_blkcipher_setkey(tfm, x->ealg->alg_key,
				    (x->ealg->alg_key_len + 7) / 8))
		goto error;
	x->props.header_len = sizeof(struct ip_esp_hdr) + esp->conf.ivlen;
	switch (x->props.mode) {
	case XFRM_MODE_BEET:
	case XFRM_MODE_TRANSPORT:
		break;
	case XFRM_MODE_TUNNEL:
		x->props.header_len += sizeof(struct ipv6hdr);
		break;
	default:
		goto error;
	}
	x->data = esp;
	return 0;

error:
	x->data = esp;
	esp6_destroy(x);
	x->data = NULL;
	return -EINVAL;
}

static struct xfrm_type esp6_type =
{
	.description	= "ESP6",
	.owner	     	= THIS_MODULE,
	.proto	     	= IPPROTO_ESP,
	.flags		= XFRM_TYPE_REPLAY_PROT,
	.init_state	= esp6_init_state,
	.destructor	= esp6_destroy,
	.get_mtu	= esp6_get_mtu,
	.input		= esp6_input,
	.output		= esp6_output,
	.hdr_offset	= xfrm6_find_1stfragopt,
};

static struct inet6_protocol esp6_protocol = {
	.handler 	=	xfrm6_rcv,
	.err_handler	=	esp6_err,
	.flags		=	INET6_PROTO_NOPOLICY,
};

static int __init esp6_init(void)
{
	if (xfrm_register_type(&esp6_type, AF_INET6) < 0) {
		printk(KERN_INFO "ipv6 esp init: can't add xfrm type\n");
		return -EAGAIN;
	}
	if (inet6_add_protocol(&esp6_protocol, IPPROTO_ESP) < 0) {
		printk(KERN_INFO "ipv6 esp init: can't add protocol\n");
		xfrm_unregister_type(&esp6_type, AF_INET6);
		return -EAGAIN;
	}

	return 0;
}

static void __exit esp6_fini(void)
{
	if (inet6_del_protocol(&esp6_protocol, IPPROTO_ESP) < 0)
		printk(KERN_INFO "ipv6 esp close: can't remove protocol\n");
	if (xfrm_unregister_type(&esp6_type, AF_INET6) < 0)
		printk(KERN_INFO "ipv6 esp close: can't remove xfrm type\n");
}

module_init(esp6_init);
module_exit(esp6_fini);

MODULE_LICENSE("GPL");
MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_ESP);

----Next_Part(Sun_Dec_16_15_54_13_2007_810)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=diff

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 4440532..096974b 100644
--- a/esp6.c
+++ b/esp6.c
@@ -177,8 +177,7 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			BUG();
 
 		if (unlikely(memcmp(esp->auth.work_icv, sum, alen))) {
-			x->stats.integrity_failed++;
-			ret = -EINVAL;
+			ret = -EBADMSG;
 			goto out;
 		}
 	}

----Next_Part(Sun_Dec_16_15_54_13_2007_810)----
