From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: [PATCH] prune: honor --expire=never
Date: Fri, 26 Feb 2010 17:21:30 -0800
Message-ID: <20100227012130.GA28452@facebook.com>
References: <20100226215916.GF5116@facebook.com>
 <7v4ol3ilri.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 02:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlBNU-0000sm-G7
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 02:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966803Ab0B0BVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 20:21:50 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:41116 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966797Ab0B0BVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 20:21:50 -0500
Received: from mail.thefacebook.com ([192.168.18.104])
	by pp01.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o1R1LGE9012619
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 Feb 2010 17:21:16 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 26 Feb
 2010 17:21:30 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1NlBN4-0008BP-2D; Fri, 26 Feb 2010 17:21:30 -0800
Content-Disposition: inline
In-Reply-To: <7v4ol3ilri.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-02-27_02:2010-02-06,2010-02-27,2010-02-26 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141163>

On Fri, Feb 26, 2010 at 04:07:45PM -0800, Junio C Hamano wrote:
> Adam Simpkins <simpkins@facebook.com> writes:
> 
> > diff --git a/builtin-prune.c b/builtin-prune.c
> > index 4675f60..ce43271 100644
> > --- a/builtin-prune.c
> > +++ b/builtin-prune.c
> > @@ -7,6 +7,8 @@
> >  #include "parse-options.h"
> >  #include "dir.h"
> >  
> > +#define ALWAYS_EXPIRE ((unsigned int)-1)
> > ...
> > @@ -34,7 +36,7 @@ static int prune_tmp_object(const char *path, const char *filename)
> >  static int prune_object(char *path, const char *filename, const unsigned char *sha1)
> >  {
> >  	const char *fullpath = mkpath("%s/%s", path, filename);
> > -	if (expire) {
> > +	if (expire != ALWAYS_EXPIRE) {
> 
> Wouldn't it be a lot simpler to initialize expire to "now" for the default
> case, and remove all these "if (expire)"?

Sure, I can submit an updated patch to do that.  It does slightly
change the behavior of "git prune" with no --expire argument though:

  - Objects with an mtime in the future will no longer be pruned.
  - We'll call lstat() all of the unreachable objects, even though it
    isn't really necessary.

However, the code is indeed simpler, if you don't think either of
these changes matter.

> I think that is how the logic
> to expire reflog entries work, which I think is saner.

Hmm.  reflog appears to have the same bug when parsing the
gc.reflogexpire and gc.reflogexpireunreachable options.  Setting
either of these to "never" or "false" results in the default
expiration time.  (However, using --expire=never on the command line
works correctly.)

I'll submit a separate patch for that.


> While you are at it, you might want to think about a way to unify what
> parse_opt_approxidate_cb() and parse_expire_cfg_value() do.  The latter
> knows about "expire = false" but the former doesn't, which is a slight
> inconsistency.

Sure, I'll look into it and submit a patch.

-- 
Adam Simpkins
simpkins@facebook.com
