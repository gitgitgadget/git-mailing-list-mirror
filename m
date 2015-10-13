From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 02/44] refs: make repack_without_refs and is_branch
 public
Date: Tue, 13 Oct 2015 17:18:16 -0400
Organization: Twitter
Message-ID: <1444771096.18742.3.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-3-git-send-email-dturner@twopensource.com>
	 <561C6EE8.3000301@alum.mit.edu> <561CB188.2090508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6yH-0001Vy-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbbJMVSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:18:46 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34457 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbJMVST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 17:18:19 -0400
Received: by qgez77 with SMTP id z77so26958804qge.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 14:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=j+QMXBTM0aaWBFw38lz1Pyz5Bb/Iqic4u8GQU8SI+Q0=;
        b=FQXUwa2Wp1opsQLF4pxrn5vRRMx+L7esfmBx891i0AzrwMGJ4B6JWLSZUZUFC0kn75
         fmL0cfGyYlZxNwyy7jb3oOcqgbG80cdMnunGWbYugCglfmRBAyMxHJkYFEwIQVvjGLUs
         6er1KqdNGGMhqvmHuXZbuTu9hRdetWYPi5AWhYJOp1yTV6qZqhSJgCDejF5k5gRUvfOH
         2EBV9pIET/0giTIGW4sGUlOEj9IVrBq7MZ3ynZZtnS4g+VV6iWFr5E5P3Ya0gkNOBdAu
         tLrq+jx9zxlVZlen0YFOuzZI0qbi1ykoyP93IYpCu1ycEy+jnY7jPaGTfh7RAg30+DLX
         GZHQ==
X-Gm-Message-State: ALoCoQl1qfypJTkxxBugUdGSpQpTpqTSeDNwhOm58YUBrLuCtNDlJFFBosjL31wwxei5zU7sKZEd
X-Received: by 10.140.234.212 with SMTP id f203mr45093487qhc.10.1444771098346;
        Tue, 13 Oct 2015 14:18:18 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id o66sm1989168qko.36.2015.10.13.14.18.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 14:18:17 -0700 (PDT)
In-Reply-To: <561CB188.2090508@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279523>

On Tue, 2015-10-13 at 09:23 +0200, Michael Haggerty wrote:
> On 10/13/2015 04:39 AM, Michael Haggerty wrote:
> > On 10/12/2015 11:51 PM, David Turner wrote:
> >> is_branch was already non-static, but this patch declares it in the
> >> header.
> >>
> >> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> >> Signed-off-by: David Turner <dturner@twopensource.com>
> >> ---
> >> [...]
> > 
> > It seems odd that repack_without_refs() should be made public (and
> > ultimately end up in refs.h) given that it intrinsically only has to do
> > with file-based references. But I will read on...
> 
> I think the reason you needed to do this was because you wanted to move
> delete_refs() to the common code. It is true that delete_ref() can be
> moved to the common code. And most of the code in delete_refs() is just
> a loop calling delete_ref(). But delete_refs() also does the very
> files-specific optimization of calling repack_without_refs() before the
> loop. *That* call shouldn't be in the common code.
> 
> So my suggestion is that you write a common_delete_refs() function that
> only includes the loop over delete_ref(), and a files_delete_refs()
> function that is basically
> 
>     {
>             result = repack_without_refs(refnames, &err);
>             if (result) {
>                     ...report error...
>                     return result;
>             }
>             return common_delete_refs(...);
>     }

OK, I can do that.  That will have to be part of the backends work, so
I'll exclude it from the refs-backend-pre-vtable patch set.
