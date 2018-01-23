Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA201F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeAWAGH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:06:07 -0500
Received: from elephants.elehost.com ([216.66.27.132]:49356 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeAWAGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:06:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0N064FL035332
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Jan 2018 19:06:04 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com>     <xmqqo9lljz3l.fsf@gitster.mtv.corp.google.com>  <001501d393d3$b82150d0$2863f270$@nexbridge.com> <xmqqy3kpihm3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqy3kpihm3.fsf@gitster.mtv.corp.google.com>
Subject: RE: [Nit] Lots of enumerated type warnings
Date:   Mon, 22 Jan 2018 19:05:58 -0500
Message-ID: <001a01d393dd$f5a65310$e0f2f930$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK5UYNG42G2iB87sMsXQlQ4bGvQ7AJJscQ9AoiR984BNC/HXqGE5LfQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 22, 2018 6:44 PM, Junio C Hamano wrote:
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > Here are a few examples, there are more:
> >
> > auto_crlf = git_config_bool(var, value);
> >   		          ^
> 
> The carets in your message do not align to what I think they are trying to
> point at, but I think the above is pointing at the '=' and wants to say
> "auto_crlf variable is enum, it gets assigned an integer returned from
> git_config_bool(), and I do not like that assignment".
> 
> For this one I tend to agree with the compiler, meaning that it is ugly to
> define "enum auto_crlf" in such a way that the first two values happen to
> match what a logically different "enum" (which is
> "boolean") assigns the two values to.  And this judgment does not change
> whether git_config_bool() actually returns an enum or an int (the code in
> reality returns the latter).
> 
> I do not think people would terribly mind a patch to turn the above
> into:
> 
>   auto_crlf = git_config_bool(var, value) ? AUTO_CRLF_FALSE :
> AUTO_CRLF_TRUE;
> 
> > "/home/jenkins/.jenkins/workspace/Build_Git/config.c", line 1147:
> > warning(272):
> >           enumerated type mixed with another type
> >
> > type = sha1_object_info(s->oid.hash, &s->size);
> >   			     ^
> 
> /* returns enum object_type or negative */ int sha1_object_info(const
> unsigned char *sha1, unsigned long *sizep)
> 
> The function has been like this forever, I suspect, and I would say "this
gives
> negative when error, or enum we know is non-negative" is quite a
> reasonable thing to do, but the enum has OBJ_BAD defined to be negative,
> so probably it is more kosher if sha1_object_info() is declared to return
> "enum object_type" instead of int.
> 
> > "/home/jenkins/.jenkins/workspace/Build_Git/diff.c", line 3618:
> > warning(272):
> >           enumerated type mixed with another type
> >
> > options->color_moved = diff_color_moved_default;
> >   	                     ^
> 
> If color_moved field is declared to be an enum, the _default variable
should
> be, too.  I do not think it is such a controversial fix.

The basic idea of the request is whether to slowly take on this type of
change. It will likely take a bit of time, but I really don't like warnings,
so am willing to work on it. There are loads more like this that might need
discussion, so I'll be pretty conservative on this effort.

Cheers,
Randall

