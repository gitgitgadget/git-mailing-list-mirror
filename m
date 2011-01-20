From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Wed, 19 Jan 2011 23:41:26 -0600
Message-ID: <20110120054126.GA4770@burratino>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 06:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfnHL-0008NU-TD
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 06:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab1ATFlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 00:41:47 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51280 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab1ATFlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 00:41:45 -0500
Received: by ywl5 with SMTP id 5so60496ywl.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 21:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=73fYtCEnHUQvLxH62eTS+eu867Id+ekSBcjAIKK/XRY=;
        b=xmz49gQ96Oi5hSkqimqVdpeyBMfvbLc/wfJWoJHrlxUmpk9aFD2ryKFTKM+US6/7nh
         avbGcEJBftaJMN2gSsMRoHN/0t9GaEPMnOXWtMzs3h2oNmbQ7yNaU8uO701lddgi0hpt
         rWZi11Iz0+JKBD26GtDqdrLRQ4d4Up87xcngI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zg4UU3ry0hGffSTh+yoXhAQCUVSNU1sqOS0jSV0zbvSAkBPqJ+93IS1fqGBdp7+v5s
         hre/4Nza/zGXOVYlJjCI2XYRTLsPx7tgEAYFCsXLMMcUpNkq61m0TyjHsLX8B5mq7x/3
         LKnGEds1p1B4Bp/r/19epazAGlANcbG5FFbvY=
Received: by 10.150.137.5 with SMTP id k5mr1876633ybd.123.1295502105221;
        Wed, 19 Jan 2011 21:41:45 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id v39sm1002361yba.7.2011.01.19.21.41.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 21:41:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtyh4smer.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165304>

Junio C Hamano wrote:

> Just thinking aloud, but is it possible to write a filter that converts an
> arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
> referenced blobs by inlining all the blobs?

A few details to watch out for:

- A mark, as in

	M 100644 :1 path/to/file

  can refer to a blob from a previous import.  A mark can even refer
  to a manually prepared marks file.

- The syntax

	M 100644 0409ac9fd3f1ea36680189e07116e58b2630ccad path/to/file

  refers to a blob that might not have been mentioned elsewhere in the
  stream.  This is the variant used by "git fast-export --no-data" to
  avoid transferring blob data.  (In general, non-git backends would
  presumably use something other than git blob IDs if they use this
  feature.  A filter of the kind we are describing would probably pass
  them through.)

  These datarefs can be acquired out of band (probably not a big deal)
  or by using the "ls" command to copy from a previous revision:

	> ls :3 "path/to/other/file"
	100644 blob 0409ac9fd3f1ea36680189e07116e58b2630ccad	git.c
	> M 100644 0409ac9fd3f1ea36680189e07116e58b2630ccad path/to/file

- The cat-blob command ("cat-blob :1") allows frontends to request
  the content of a previously imported blob (presumably in order to
  apply a delta to it).

So while something like the filter you describe seems possible, it
cannot be as simple as

	mkfifo replies &&
	fast-export-frontend 3<replies |
	inline-blobs |
	fast-import-backend --cat-blob-fd=3 <args> 3>replies

for general <frontend> and <backend>.  The frontend might try to cat
blobs by mark number or to pick off where it left off in a previous
run using a marks file.
