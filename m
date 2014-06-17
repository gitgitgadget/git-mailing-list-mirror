From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 2/3] tree-walk: simplify via strnncmp()
Date: Tue, 17 Jun 2014 00:13:32 -0700
Message-ID: <20140617071332.GA3940@hudson.localdomain>
References: <cover.1402945507.git.jmmahler@gmail.com>
 <571d131f6ebeadb33999fe086656cb642710fb6f.1402945507.git.jmmahler@gmail.com>
 <20140616201806.GO8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwnaO-0000Qm-8J
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 09:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaFQHNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 03:13:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33856 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaFQHNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 03:13:36 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so5378618pab.36
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7YN6KP5PWvvnoYydUJ2rdWBQDlhjIq8K+Y3mB2bFMWY=;
        b=p35nFcCQJ8MfQ1LMovycjDzRsMy2fzoTruFjQc54uk2G44BAxp8MJIKLnsSna4LtlM
         g8XzEBZmwI/zSs0CNJ3CC5vaNX/hVep16cEDLr867Gje44EuvBZehGpZdqvfsW1HpQOX
         4T1htwVvtvhhGndAU8fOSEaVWq7KUFTj0Zu/FWNWb4NM0nhEZW068Mu5v+/Nr88YVNVG
         mm+YyjY7Gkn2t9QpReynPLiuV6AdB7ZC6TPKc2bQpDtWECXVPXNxdtDawDkl2i6Js+//
         fiBcYIXQJ9MYvuMjzd+gzMpieZ2dxA+l7o8I+GweQTTJJyzEiqg6Ki0jNjuomO3M0fle
         FizA==
X-Received: by 10.66.254.68 with SMTP id ag4mr30471694pad.83.1402989215661;
        Tue, 17 Jun 2014 00:13:35 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id kn1sm22365969pbd.13.2014.06.17.00.13.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 00:13:34 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140616201806.GO8557@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251846>

Jonathan,

On Mon, Jun 16, 2014 at 01:18:06PM -0700, Jonathan Nieder wrote:
> Jeremiah Mahler wrote:
> 
> > --- a/tree-walk.c
> > +++ b/tree-walk.c
> [...]
> > @@ -174,7 +164,7 @@ static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
> >  	 * scanning further.
> >  	 */
> >  
> > -	int cmp = name_compare(a, a_len, b, b_len);
> > +	int cmp = strnncmp(a, a_len, b, b_len);
> 
> This changes behavior: the old version would only have 0 < cmp if
> 'a' comes after 'b', while the new version always has 0 < cmp when
> a != b.

Thanks for catching this.  I did not realize that when I tried to
cleanup the logic I inadvertently changed its behavior.

    int strnncmp(const char *a, int len_a, const char *b, int len_b)
    {
           int min_len = (len_a < len_b) ? len_a : len_b;
           return (memcmp(a, b, min_len) || (len_a - len_b));
    }

is not the same as:

    static int name_compare(const char *a, int a_len,
                           const char *b, int b_len)
    {
           int len = (a_len < b_len) ? a_len : b_len;
           int cmp = memcmp(a, b, len);
           if (cmp)
                   return cmp;
           return (a_len - b_len);
    }

(-5 || 3) is 1, not -5.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
