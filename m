From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3] builtin-remote: move duplicated cleanup code its own 
	function
Date: Wed, 11 Feb 2009 20:44:13 -0500
Message-ID: <76718490902111744p27e83238x34cb7004d8e3e48f@mail.gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
	 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
	 <20090212001836.GB30231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:45:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQe6-0006cz-C5
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367AbZBLBoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757136AbZBLBoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:44:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:52718 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933AbZBLBoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:44:15 -0500
Received: by rv-out-0506.google.com with SMTP id g9so432221rvb.5
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 17:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CSNXVmCJGcbh9VnLIi8DV6UkelQsPYNTlURwikDAZA4=;
        b=xv5mg1/PZSHeXboLoDjfZjGA3TPlp0wbs5/2xujNSdFI03HV94wbMPaMJCWy4kcuxS
         kFGGiPFWjNAbs1laPl2hddVNlpVXNbF0pOTHeLo9+fqJ6nK0YkodnvWir2/hxNoQyWle
         XT9A1oWYS/Z7XlCFDQk2tMoLukXemP4ezfGcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b3C5RI/MbEppYCsmck+eLUu+XiKYWJNgHgxJjwuR8uPX4LCtLYaYSvOBxWpJaEOa8Y
         4jANzOKOhuV84gTW3cZMlLViURIMZc55wSDimj/eBnwIGPR+w4nyZo7rxTccN7JyLeWa
         XTOwim8JiRiDxRGkO2OfoeLIfss4X6mYMDqec=
Received: by 10.141.5.17 with SMTP id h17mr179650rvi.195.1234403054093; Wed, 
	11 Feb 2009 17:44:14 -0800 (PST)
In-Reply-To: <20090212001836.GB30231@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109555>

On Wed, Feb 11, 2009 at 7:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 01:01:21AM -0500, Jay Soffian wrote:
>
>> +static void free_remote_ref_states(struct ref_states *states)
>> +{
>> +     /* NEEDSWORK: free remote */
>> +     string_list_clear(&states->new, 0);
>> +     string_list_clear(&states->stale, 0);
>> +     string_list_clear(&states->tracked, 0);
>> +}
>
> Hmm. I don't know anything about this code, so maybe it is not trivial.
> But anytime you are touching an area that NEEDSWORK, I think it is worth
> looking at whether you can fix that problem (since you have already
> spent a few brain cycles understanding what is going on in general).

I spent about 5 minutes which was enough time for me to realize that
the reason the previous author left it as "NEEDSWORK" is because
fixing it is more than 5 minutes of work. This is the remote object --
maybe you could offer me some clues that allow me to know which of its
fields need to be freed individually:

struct remote {
	const char *name;
	int origin;

	const char **url;
	int url_nr;
	int url_alloc;

	const char **push_refspec;
	struct refspec *push;
	int push_refspec_nr;
	int push_refspec_alloc;

	const char **fetch_refspec;
	struct refspec *fetch;
	int fetch_refspec_nr;
	int fetch_refspec_alloc;

	/*
	 * -1 to never fetch tags
	 * 0 to auto-follow tags on heuristic (default)
	 * 1 to always auto-follow tags
	 * 2 to always fetch tags
	 */
	int fetch_tags;
	int skip_default_update;
	int mirror;

	const char *receivepack;
	const char *uploadpack;

	/*
	 * for curl remotes only
	 */
	char *http_proxy;
};

I *think* const is a clue that the field need not be freed, because
the pointer is to storage that is on the stack. But I wasn't sure, esp
with the double pointers. And I really wasn't sure about the struct
pointers.

Really, I only pretend to know C. :-)

j.
