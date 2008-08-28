From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/3] Give NoRemoteRepositoryException better
	message in BasePackConnection
Date: Wed, 27 Aug 2008 19:44:37 -0700
Message-ID: <20080828024437.GD8624@spearce.org>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com> <20080828023501.GC8624@spearce.org> <48B61016.7050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXW3-0000py-1a
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYH1Coi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbYH1Coi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:44:38 -0400
Received: from george.spearce.org ([209.20.77.23]:58107 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbYH1Coi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:44:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 85EF938375; Thu, 28 Aug 2008 02:44:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B61016.7050401@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94028>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Shawn O. Pearce wrote:
> (...)
>> +	@Override
>> +	protected TransportException noRepository() {
>> +		// Sadly we cannot tell the "invalid URI" case from "push not allowed".
>> +		// Opening a fetch connection can help us tell the difference, as any
>> +		// useful repository is going to support fetch if it also would allow
>> +		// push. So if fetch throws NoRemoteRepositoryException we know the
>> +		// URI is wrong. Otherwise we can correctly state push isn't allowed
>> +		// as the fetch connection opened successfully.
>> +		//
>> +		try {
>> +			transport.openFetch().close();
>> +		} catch (NotSupportedException e) {
>> +			// Fall through.
>> +		} catch (NoRemoteRepositoryException e) {
>> +			// Fetch concluded the repository doesn't exist.
>> +			//
>> +			return e;
>> +		} catch (TransportException e) {
>> +			// Fall through.
>> +		}
>> +		return new TransportException(uri, "push not permitted");
>> +	}
>> +
>
> Nice idea, even if it's crazy and time-consuming, it's probably better  
> than my previous one.

I'm not too worried about the extra time used here.

This happens only after we have already opened a connection and
received no refs at all from the remote peer.  So the user has
already had to wait to get this far.

By asking the same transport to open the fetch we can reuse an
existing SSH tunnel for the new command if this is an SSH connection,
so the setup costs are a lot lower then the original connection.

We are already in a bad error condition; we cannot continue and
the user is about to get an error.  I would rather give them the
best error message we can determine than abort early and give them
something misleading.

-- 
Shawn.
