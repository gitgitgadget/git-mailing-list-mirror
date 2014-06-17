From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 08:49:26 -0700
Message-ID: <20140617154926.GB5162@hudson.localdomain>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
 <CABPQNSZ7Vhn1Pz4j0R5twg+P-UzOG6xfw7fNqp0JO_Sh5t3CiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvde-0005gG-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbaFQPtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:49:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:63312 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084AbaFQPta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:49:30 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so3099183pde.31
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6/SABvm+AdOtxu3n5zIo0NeZ7PHVVgKGPzn/GOI4ELg=;
        b=I6eTcwInDnQIWfAGFThUUAJ1M8Mpu79uqRnOY7Cd5rkiqSllzDnoyzXhJ/nRhquJII
         gJ87owk9+z60Cipy/xBM+a3VZabx6Psyy9Ue4p5egg5Z7KR8/TcXgI4t+xG5UpHqCsKT
         WREEcrt0z5buc7T138P7HmsmpMyLzHRQqKNkGq+Nh2Gh+ImjgZjwQfZHo71xOEKsPf7P
         7phbIgKBop6br3QiX3K6+ETh855bcRDSZ2rg0kC94XNc2I3RYmlex4rzUfLOfYKS1Mj5
         OF5nK+X+2JlrT4OCLI8tFGFoB6J/Dt6VtmXZSKlnejyYG+JtSrLqb04MDnZ/NQxCwpmQ
         9l2Q==
X-Received: by 10.66.163.38 with SMTP id yf6mr34501872pab.46.1403020169859;
        Tue, 17 Jun 2014 08:49:29 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ha10sm24665464pbd.1.2014.06.17.08.49.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 08:49:28 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CABPQNSZ7Vhn1Pz4j0R5twg+P-UzOG6xfw7fNqp0JO_Sh5t3CiA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251868>

Erik,

On Tue, Jun 17, 2014 at 11:09:59AM +0200, Erik Faye-Lund wrote:
> On Tue, Jun 17, 2014 at 9:34 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > Add a strnncmp() function which behaves like strncmp() except it takes
> > the length of both strings instead of just one.  It behaves the same as
> > strncmp() up to the minimum common length between the strings.  When the
> > strings are identical up to this minimum common length, the length
> > difference is returned.
> >
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  strbuf.c | 9 +++++++++
> >  strbuf.h | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index ac62982..4eb7954 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
> >         result[i] = '\0';
> >         return result;
> >  }
> > +
> > +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> > +{
> > +       int min_len = (len_a < len_b) ? len_a : len_b;
> > +       int cmp = strncmp(a, b, min_len);
> > +       if (cmp)
> > +               return cmp;
> > +       return (len_a - len_b);
> > +}
> 
> Using a name that sounds like it's from the stdlib makes me cringe a
> little bit. Names that start with "str" reserved for stdlib[1][2], but
> we already ignore this for strbuf (and perhaps some other functions).
> However, in this case it doesn't seem *that* unlikely that we might
> collide with some stdlib-extensions.
> 
> [1]: http://pubs.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_02.html#tag_02_02_02
> [2]: http://www.gnu.org/software/libc/manual/html_node/Reserved-Names.html

I chose strnncmp() to try and emphasize its similarity to strncmp().
But you have a good point about potential name conflicts.  That could be
a problem.  I will change the name.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
