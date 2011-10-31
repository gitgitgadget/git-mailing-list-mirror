From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jc/lookup-object-hash from pu crashes on ARM
Date: Mon, 31 Oct 2011 07:56:48 -0500
Message-ID: <20111031125648.GA1757@elie.hsd1.il.comcast.net>
References: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 13:57:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKrQH-00006z-88
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 13:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116Ab1JaM47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 08:56:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46762 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab1JaM47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 08:56:59 -0400
Received: by gyb13 with SMTP id 13so5833773gyb.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=euGeiDY1KqiW3iDRQ5+wbhTsbCwj33+Ybq0002+gHOQ=;
        b=ZRpqd+DoytZokV8bwGhlyR5Y4qTpbtHr8j7xEAC6lhQI96OzBO0KKtYODlBkB12PQN
         aRqtTUjOJ28qW5qnWqaeY8wh+cNVYDtqwtbr7CXuR7HRe4micYZbEnrOJ73oj6GyUoCU
         TvtQBc7HzkUBizpWQlB4zuILKX61AzF/QMhDA=
Received: by 10.236.191.71 with SMTP id f47mr16694179yhn.7.1320065818517;
        Mon, 31 Oct 2011 05:56:58 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c68sm25747050yhi.7.2011.10.31.05.56.56
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 05:56:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184504>

Junio C Hamano wrote:

> * jc/lookup-object-hash (2011-08-11) 6 commits
>  - object hash: replace linear probing with 4-way cuckoo hashing
>  - object hash: we know the table size is a power of two
>  - object hash: next_size() helper for readability
>  - pack-objects --count-only
>  - object.c: remove duplicated code for object hashing
>  - object.c: code movement for readability

The code from the tip commit crashes on ARM for me (and presumably
would also misbehave on other platforms that care about alignment):

 $ git branch -av
 Bus error

The following might avoid that:

	static inline unsigned int H(const unsigned char *sha1, int ix)
	{
		unsigned int hash;
		memcpy(&hash, sha1 + ix * sizeof(unsigned int),
				sizeof(unsigned int));
		return hash % (obj_hash_size - 1);
	}

Even better could be to start aligning the hashes we pass around,
using something like this:

	union object_hash {
		unsigned char sha1[20];
		uint32_t chunk[5];
	};

which could speed up functions like hashcpy(), hashcmp(), and
hasheq().  But it's probably not worth the fuss.

Call chain:

	cmd_branch -> print_ref_list -> for_each_rawref ->
	  do_for_each_ref -> do_one_ref(entry=0x175508) ->
	  append_ref(sha1=0x175509) ->
	  lookup_commit_reference_gently -> parse_object ->
	  parse_object_buffer -> lookup_commit -> lookup_object

This is from testing pu (ed7c265e), in case that's relevant.  Aside
from that, the topic looks neat. :)
