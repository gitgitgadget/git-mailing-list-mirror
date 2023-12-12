Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BEF1
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 16:46:51 -0800 (PST)
Received: (qmail 4882 invoked by uid 109); 12 Dec 2023 00:46:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 00:46:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8597 invoked by uid 111); 12 Dec 2023 00:46:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 19:46:49 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 19:46:49 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 5/7] submodule: handle NULL value when parsing
 submodule.*.branch
Message-ID: <20231212004649.GA376323@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071129.GE1276005@coredump.intra.peff.net>
 <ZXF--AxCOOOjyOMc@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXF--AxCOOOjyOMc@tanuki>

On Thu, Dec 07, 2023 at 09:14:48AM +0100, Patrick Steinhardt wrote:

> > diff --git a/submodule-config.c b/submodule-config.c
> > index 6a48fd12f6..f4dd482abc 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> > @@ -516,7 +516,9 @@ static int parse_config(const char *var, const char *value,
> >  			submodule->recommend_shallow =
> >  				git_config_bool(var, value);
> >  	} else if (!strcmp(item.buf, "branch")) {
> > -		if (!me->overwrite && submodule->branch)
> > +		if (!value)
> > +			ret = config_error_nonbool(var);
> > +		else if (!me->overwrite && submodule->branch)
> >  			warn_multiple_config(me->treeish_name, submodule->name,
> >  					     "branch");
> >  		else {
> 
> I was about to say that I'd rather expect us to handle this gracefully
> so that Git doesn't die when parsing an invalid gitmodules file. But
> there are other cases where we already fail in the same way, so this
> looks good to me.

We're just returning the error here, so it's really up to the caller to
decide what to do. The config API has an "error_action" field in the
options struct. By default for reading from a blob, this will propagate
the error, and I think that's what we use in most of the submodule code.

For the code in fsck which looks at gitmodules, it suppresses the error
text from the config API (in favor of its own fsck-specific message).
Of course it does not suppress the error() from config_error_nonbool,
which writes straight to stderr. So there may be some room for
improvement, but I doubt anybody cares too much in practice if fsck is a
little chatty when it sees breakage.

-Peff
