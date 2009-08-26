From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Wed, 26 Aug 2009 20:20:53 +0800
Message-ID: <20090826202053.6e6442a6.rctay89@gmail.com>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
 <20090817135651.GA4570@harikalardiyari>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 14:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgHWS-0002nO-49
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 14:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbZHZMWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 08:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbZHZMWa
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 08:22:30 -0400
Received: from mail-pz0-f192.google.com ([209.85.222.192]:65350 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbZHZMW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 08:22:29 -0400
Received: by pzk30 with SMTP id 30so85295pzk.4
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FdhF8YT2sFa3/uoF544Hv6/guOl0YAULtCfkYayQYrg=;
        b=dOEb8f5ea6NCzWZyBkeVi8uhzKO0IEoveDfziYHsvtLBoeRjUEZyMrivy5szhinCsf
         vcUsWD7fUkhFZh3O2eB5YR9AW/91fnKj/q6zKzhrR6nF/xtsj6ETwFaQ+ulAOyIVmr1+
         40e8MydmLHkv3jLbLt8Ozlmqq2AEq+9dP5gKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=oUui/rmWxz1TB7tmDITKQnu4AJc9Sbiml/ayJHPZJjftJnTAZeb7s7n3SqQwyvIM96
         80AC19PDzYVxBymxJPWrmx55gzsWzYYMQR+JEjdpTcyd2QasLuYCV9qaC9JzD2v59SQo
         XUeRKSJR6NKS+59tIv0p7C4v68cusaz80L/Cw=
Received: by 10.115.99.13 with SMTP id b13mr9789233wam.188.1251289350095;
        Wed, 26 Aug 2009 05:22:30 -0700 (PDT)
Received: from your-cukc5e3z5n (cm74.zeta152.maxonline.com.sg [116.87.152.74])
        by mx.google.com with ESMTPS id n40sm334214wag.21.2009.08.26.05.22.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Aug 2009 05:22:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127092>

Hi,

On Mon, Aug 17, 2009 at 10:22 PM, Johannes Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Seems that an object request is aborted, but the slot, and therefore the
> callback, is called nevertheless.  Tay, does that ring a bell?

thanks Johannes, your diagnosis was a vital clue.

Ali, could you see if this patch fixes it for you? On my side, I had
some difficulty reproducing your problem reliably (it happened
sometimes but not on other times).

--
Cheers,
Ray Chuan

-- >8 --
Subject: [PATCH] http.c: set slot callback members to NULL when releasing object

Set the members callback_func and callback_data of freq->slot to NULL
when releasing a http_object_request. release_active_slot() is also
invoked on the slot to remove the curl handle associated with the slot
from the multi stack (CURLM *curlm in http.c).

These prevent the callback function and data from being used in http
methods (like http.c::finish_active_slot()) after a
http_object_request has been free'd.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index a2720d5..1ae19e0 100644
--- a/http.c
+++ b/http.c
 -1285,5 +1285,10 @@ void release_http_object_request(struct http_object_request *freq)
 		free(freq->url);
 		freq->url = NULL;
 	}
-	freq->slot = NULL;
+	if (freq->slot != NULL) {
+		freq->slot->callback_func = NULL;
+		freq->slot->callback_data = NULL;
+		release_active_slot(freq->slot);
+		freq->slot = NULL;
+	}
 }
--
1.6.4.193.gaceaa.dirty
