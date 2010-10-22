From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 09:55:53 -0500
Message-ID: <20101022145553.GA9224@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
 <7vaam7rv49.fsf@alter.siamese.dyndns.org>
 <201010221611.15425.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 16:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9J5y-0008Cc-Mi
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 16:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0JVO7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 10:59:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34059 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab0JVO7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 10:59:44 -0400
Received: by eye27 with SMTP id 27so1099818eye.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AemyqvmSdCkTxUpg576eyLeujeEIdIhvzXHVcMHd/Go=;
        b=rjqPx79vlcOmCpA7Ia+AV2y/BR59RJqDL016eVXlqq731EO4RDMSfVX7ddrE8GkZBl
         VSdv5YGog4ZR05nBm4biWkQ1zGLjsn1L3dpwJSKCIBGdrJApUZVjtWPnws87FbUbssuq
         j22Z6veJBSKu+TH7dQaMsgxuvGnDgGuluECbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b22F+Swg5paVwDv5lLEymLkciAhVY0+XI8cA11qUSzK3+cauDO8z3Eah8rlG1Iohhp
         EwEfCJMhnbqy1TP8ENTUMZe/++32SuW6tMwCsbNhN8nf2Wdwa/bqnP7ObppWCR5493op
         8hI+fZVfTXgpXVhdB8+0QASNCs5vyDRZbkLag=
Received: by 10.14.119.7 with SMTP id m7mr2237672eeh.39.1287759583088;
        Fri, 22 Oct 2010 07:59:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e16sm986919vcm.8.2010.10.22.07.59.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 07:59:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010221611.15425.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159694>

Johan Herland wrote:

> Does this mean that there are situations where you simply _cannot_ get 
> back to the pre-merge state (using 'git reset --merge' or otherwise)?

Technically yes, there is such an edge case, but I don't think that
was what he was talking about.

> Is this something we should detect and warn about when starting the 
> merge? Something like:
> 
>   $ git merge bar
>   I'm sorry, Dave. I'm afraid I can't merge with and unclean index.
>   Use -f to force the merge anyway, but then 'git merge --abort' will
>   lose your staged changes.

"Use -f to force the merge anyway" does not make sense to me.
git merge does not work with an index that does not match HEAD (except
in the aforementioned edge case where the content in the edge already
matches the merged content).  So 'git merge' bails out in this case,
leaving the index as-is; if a person doesn't notice that and tries
'git reset --merge', her staged changes may be clobbered.

> Or could we solve it simply by making a backup of the pre-merge index 
> that can later be restored by 'git merge --abort'?

Yes, that's one way.  I think it might be better for 'git reset
--merge' to check for MERGE_HEAD and do nothing if it is absent if we
want it to be closer to an inverse to failed 'git merge'.
