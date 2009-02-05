From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 01/11] Add support code to handle plugin property
 changes
Date: Thu, 05 Feb 2009 17:35:47 +0100
Message-ID: <498B1563.4070905@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-2-git-send-email-torarnv@gmail.com> <20090205155337.GH26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7EA-0005wm-9K
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbZBEQfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbZBEQfx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:35:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:16212 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZBEQfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:35:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so225729fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 08:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PwcDRbJBELiqUSts7tO6hyRTM6HQ08dg23uBVTTJ2l4=;
        b=SioLr25XpzaMhfHQp54ZUgqq9rb2BvDslGYxtXeWPP3M09GeDFD4zssNd3roYK+h1s
         BTBmAYfRRGph8UHZ4lrlQz8CMwvdB7hQH9TRPRm0ub05g7ra1QjUdbsv/nsu9+UkUQ2W
         3cGLRD9SYNT539dKhUXh+Vb5uzuIT6HmXtzSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vph9j9YlbIu0zUtSMAtk/4p+tmS085BggOV3TmWAGfM8bYOWna8ayxL8wzBgTjaJqJ
         +o9FmocnqNqs+RSivSWJzsc9RTlO5X4zdvW3g0wUR4LJWmyulsvBViNfQakh8DDLsa/b
         OWuka4GxmzIuMfHEGLSk4T+vEPf01385el8xY=
Received: by 10.86.4.2 with SMTP id 2mr428662fgd.50.1233851750623;
        Thu, 05 Feb 2009 08:35:50 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l19sm1793000fgb.57.2009.02.05.08.35.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 08:35:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090205155337.GH26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108578>

Shawn O. Pearce wrote:
> Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
>> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.j=
ava b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
>> index fced643..d4a9e8e 100644
>> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
>> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
>> @@ -44,9 +48,24 @@
>>   * This is a plugin singleton mostly controlling logging.
>>   */
>>  public class Activator extends AbstractUIPlugin {
>> +
>> +	/**
>> +	 *  The one and only instance
>> +	 */
>>  	private static Activator plugin;
>=20
> What does this field do?  I don't see it referenced anywhere...

It's the singleton instance, referenced from Activator.getDefault(). I
just documented it :)

>>  	/**
>> +	 * Property listeners for plugin specific events
>> +	 */
>> +	private static List<IPropertyChangeListener> propertyChangeListene=
rs =3D
>> +		new ArrayList<IPropertyChangeListener>(5);
>=20
> None of these list accesses are thread-safe.  Are we certain they
> call will come from a single thread, e.g. the SWT event thread?
> Or do we need to put synchronized protection in here?

The addPropertyChangeListener method is called at startup from the
GitLightweightDecorator constructor, in one of the worker threads, and
same thing with removePropertyChangeListener from dispose(). The
broadcastPropertyChange method is called in the main thread every time
the Git decorator preference page is closes.

This is the sync model used by other Eclipse plugins for keeping track
of propertyChangeListeners, for example in the TeamUIPlugin, that's why
I assumed it was OK. I'm perfectly fine with syncrhronizing it though,
similar to repositoryChangeListeners in GitProjectData?

Tor Arne
