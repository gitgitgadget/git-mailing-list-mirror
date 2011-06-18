From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Sat, 18 Jun 2011 16:52:02 +0200
Message-ID: <4DFCBB92.5040308@lsrfire.ath.cx>
References: <20110614181732.GA31635@sigill.intra.peff.net> <20110614181821.GA32685@sigill.intra.peff.net> <4DF7B90B.9050802@lsrfire.ath.cx> <20110614201433.GB1567@sigill.intra.peff.net> <20110614204521.GA12776@sigill.intra.peff.net> <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 17:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXx0d-0004Fi-1W
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 17:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab1FRPAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 11:00:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:49775 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1FRPAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 11:00:20 -0400
Received: from [192.168.2.106] (p4FFDB206.dip.t-dialin.net [79.253.178.6])
	by india601.server4you.de (Postfix) with ESMTPSA id 5C3EE2F80D1;
	Sat, 18 Jun 2011 16:52:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175972>

Am 16.06.2011 00:30, schrieb Jeff King:
> On Tue, Jun 14, 2011 at 04:45:21PM -0400, Jeff King wrote:
> 
>> The gzip path is not configurable at all. Probably it should read the
>> path and arguments from the config file. In fact, we could even allow
>> arbitrary config like:
>>
>>   [tarfilter "tgz"]
>>     command = gzip -c
>>     extension = tgz
>>     extension = tar.gz

Configuration options whose values are appended instead of overwritten
by duplicate definitions are a new concept for git, I think.  Perhaps
it's not a big thing, but I think it's better avoided.

The only (stupid) practical shortcoming I can think if is this, though:
You can't remove anything from the list of supported extensions in a
user config if the system config already contains e.g. tgz and tar.gz.

> Here's a series implementing that. You can configure whatever you want,
> and it includes builtin gzip configuration by default. You can override
> to turn it off, or even switch it to run something like pigz instead.
> 
> My biggest reservation with the patches as-is is that they are very
> tar-centric and not orthogonal. Specifically, they won't handle:
> 
>   1. Other streamable archive formats you would want to pipe through
>      compressors. Do any of these actually exist? I guess we could offer
>      "pax" as a format eventually, and it might be like tar with
>      different defaults? I dunno.
> 
>      Fixing this would not be too hard. Instead of these being
>      "tarfilters", they would be "archive filters", and they would chain
>      to some format, defaulting to "tar".  Since there is no other
>      format right now, we could even punt on writing most of the code
>      until somebody adds one. But we would want to get the naming of the
>      config options right, since those are user-facing. Maybe
>      "archivefilter" (unfortunately the more readable archive.filter is
>      a little awkward with the way we parse config files)?

The pax format is identical to the ustar format, which --format=tar
produces.  The other major format that comes to mind is cpio.  The
(never merged) predecessor of tar-tree actually used that format.

Since then I have been waiting for users to request being able to export
using cpio format (which is simpler and slightly smaller than tar), but
that never happened.  It seems the existence of the pax format really
has pacified the tar vs. cpio war of old.

I'm not sure "filter" is a good name, though.  We have core.pager, which
is technically a filter as well, but for a specific purpose.  And we
have the tar.umask setting as a precedence for format specfic config
options.  So how about tar.<extension>.compressor?

	[tar "tgz"]
		compressor = gzip -cn
	[tar "tar.gz"]
		compressor = gzip -cn
	[tar "tar.bz2"]
		compressor = bzip2 -c

We don't need a compressionlevels option here because we can simply
assume that the compressor commands do support them.  (Side note: this
is not fully true for bzip2, as it doesn't support -0, but I don't think
this is worth special consideration in our code, as long as errors of
the filter are displayed properly.)

And we can also add a config option to restrict the formats creatable by
upload-archive, to address concerns over DoS attacks with expensive
compressors:

	[archive]
		remoteFormats = tar zip tgz tar.gz
