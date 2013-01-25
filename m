From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 21:53:31 -0800
Message-ID: <20130125055331.GC26524@elie.Belkin>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TycIj-0001nj-UA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab3AYFxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 00:53:39 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44504 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3AYFxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 00:53:38 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so6672pbc.19
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 21:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qKesjwYsXDnW7+pAQzZjetXrJ5f/baJ/Axd87OLObh8=;
        b=bF7t8QmX2IGqMH/6Jjt5EUN1miUHeUXdVu2NwQtOpBHo72hVoreDvY0F+/cl9q6WNF
         UZvAwJXI2rfLjmBkJ655Sz3B71voPcpNZ7J/raTYdw7Dtf+7VDxlQxuI55XVk5CbtUxY
         Z5kA6M1lc8nVWtOFfZPhYbY2BZBWumyuE1eihYyMVHMvsUjb7H6fv2fjqajcPQEaZZ/Z
         vKztdWiFkH3zkc+PhNIIEaMhiag+zcCI0oH8xZqG9erfhlS8orqJS2mZo5njhPrKNxiH
         +haieuB0hAYz/yPH5Tmn/E3cx8+p01XhXRLg55XMohBlFOP/aBhAehJfMNo1ZNu3fVfA
         /BsQ==
X-Received: by 10.68.251.233 with SMTP id zn9mr11555032pbc.7.1359093217914;
        Thu, 24 Jan 2013 21:53:37 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id o5sm183411paz.32.2013.01.24.21.53.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 21:53:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214501>

Hi,

Junio C Hamano wrote:

> I've been toying with an idea along this line.

Heh.  Just for fun, here's an uglier version:

	struct wcb_data {
		int had_buffer;
		int using_buffer;
	};
	#define WITH_COMMIT_BUFFER_DATA_INIT { 0, 0 }

	extern void acquire_commit_buffer(struct commit *, struct wcb_data *);
	extern void done_with_commit_buffer(struct commit *, struct wcb_data *);

	/*
	 * usage:
	 *	struct wcb_data buf = WITH_COMMIT_BUFFER_INIT;
	 *
	 *	with_commit_buffer(commit, buf) {
	 *		...
	 *	}
	 */
	#define with_commit_buffer(commit, i) \
		for (acquire_commit_buffer(commit, &i); \
		     i.using_buffer; \
		     done_with_commit_buffer(commit, &i))

	void acquire_commit_buffer(struct commit *commit, struct wcb_data *i)
	{
		enum object_type type;
		unsigned long size;

		assert(!i->using_buffer);
		i->using_buffer = 1;
		i->had_buffer = !!commit->buffer;

		if (i->had_buffer)
			return;
		commit->buffer = read_sha1_file(commit->object.sha1, &type, &size);
		if (!commit->buffer)
			die("unable to read commit %s", sha1_to_hex(commit->object.sha1));
	}

	void done_with_commit_buffer(struct commit *commit, struct wcb_data *i)
	{
		assert(i->using_buffer);
		i->using_buffer = 0;

		if (!i->had_buffer) {
			free(commit->buffer);
			commit->buffer = NULL;
		}
	}
