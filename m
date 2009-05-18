From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Mon, 18 May 2009 16:30:25 +0800
Message-ID: <20090518163025.58842505.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 10:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5yFB-0004a6-2G
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZERIae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZERIae
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:30:34 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:58728 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZERIad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:30:33 -0400
Received: by pxi29 with SMTP id 29so1855280pxi.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=05eb0j0suJYWzT/vWgd+q8pweZMgaTImklHdKIF63Jw=;
        b=u6vKvbFEP0O56741Z279ScjbWznBgIUroAKSrIdbmWC4TkkY5LfUN/AJYbS+u650SC
         NZ6vv7e1Ektwc9V9jw5zQVo0yq+eT2eZRHoWUGq3wHr9qnyKtyqQy/D2IhUzh9C+culC
         bLSUfDhfC8udZcap6uZkLRRr0mOy0cuPUxvkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BFkunTJ25iMFuZoh5qcV3ykLxFx3VAwoHza2pHbuYuBrnJ1Ez87LcAQ43cRqL+KZPv
         RjJQ+wtP6I5zLk7Zi4Lwh7HI9y8QK3LIQvndlWfp1lurvjdfulaPQMPlHYKl2UZA8+Fl
         qPFVhYYPsEn1s2xATtu6ldqF+L7JmJ+TeeMVg=
Received: by 10.114.200.2 with SMTP id x2mr11109798waf.83.1242635434260;
        Mon, 18 May 2009 01:30:34 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id j31sm4636536waf.62.2009.05.18.01.30.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 01:30:33 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119427>

This patch series applies on pu.

The major differences between this series and the 11-patch long one
(dated May 15, 2009) are:

 *check 'preq' pointer before using it (for fetching packs) [1]
 *moved free(url) before 'abort' label to stop -Wuninitialized warning
  (for fetching loose objects) [2]
 *use unlink_or_warn, after 691f1a2 ("replace direct calls to unlink
  (2) with unlink_or_warn")

Junio: I've rebased the patch series on pu, hopefully this stops the
attribute warnings for patch 3.

Tay Ray Chuan (3):
  http*: add helper methods for fetching packs
  http*: add helper methods for fetching objects/info/packs
  http*: add helper methods for fetching objects (loose)

 http-push.c   |  378 ++++++++--------------------------------------------
 http-walker.c |  407 +++++++++++---------------------------------------------
 http.c        |  415 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h        |   72 ++++++++++-
 4 files changed, 616 insertions(+), 656 deletions(-)

Footnotes:
[1] @@ -595,17 +595,21 @@ static void finish_request(struct transfer_request *request)
     			start_fetch_packed(request);
     
     	} else if (request->state == RUN_FETCH_PACKED) {
    +		int fail = 1;
     		if (request->curl_result != CURLE_OK) {
     			fprintf(stderr, "Unable to get pack file %s\n%s",
     				request->url, curl_errorstr);
    -			repo->can_update_info_refs = 0;
     		} else {
     			preq = (struct http_pack_request *)request->userData;
     
    -			if (finish_http_pack_request(preq))
    -				repo->can_update_info_refs = 0;
    +			if (preq) {
    +				if (finish_http_pack_request(preq) > 0)
    +					fail = 0;
    +				release_http_pack_request(preq);
    +			}
     		}
    -		release_http_pack_request(preq);
    +		if (fail)
    +			repo->can_update_info_refs = 0;
     		release_request(request);
     	}
     }
    
[2] @@ -1167,9 +1167,9 @@ struct http_object_request
    *new_http_object_request(const char *base_url, 
     	return freq;
     
    +	free(url);
     abort:
     	free(filename);
    -	free(url);
     	free(freq);
     	return NULL;
     }
