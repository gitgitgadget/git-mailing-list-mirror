From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 18:09:01 +0000
Message-ID: <320075ff0902161009s1454e1feu5b3543f898112406@mail.gmail.com>
References: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
	 <20090216172025.GE18525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7vQ-0004Ke-Fp
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZBPSJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZBPSJH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:09:07 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51993 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbZBPSJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:09:04 -0500
Received: by bwz5 with SMTP id 5so3275837bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BMAKP+wTMKHAm4i1tDigBNCDNNmm5o8PYnCR6PnJmts=;
        b=KpZ+XN7k5iUb/QNh6Ln05cwCIMrHUjA+jdOXKPitEuZhR18uwrMrR32lCFc1zzjmoc
         V0odf/dndaNRxmbfYP7aJNpA4RtlGt+zqWKp8duE+nSr9jS8xxxgUswoIIpdgvHGTdAy
         aS/z/aXpXtgWKb3ldBTrB5IRr1EKIYYXg1C3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZnSUrTgmGFw+7IOqdjTQbawkHUsiOduDXg+iQ7kfgiosg6CYB3GrMkJS17SeRHhyoY
         rGs5Dkm+xTxXuPGaN3eDoWKkESGiRC/0voJSYwQ3de5gBwwLblplPNaO/qhwZ96k8Xy4
         ngi8gfGWvs64hhrI5Obg4J14zjnbcH5ViZa9Q=
Received: by 10.223.118.15 with SMTP id t15mr7020074faq.85.1234807741840; Mon, 
	16 Feb 2009 10:09:01 -0800 (PST)
In-Reply-To: <20090216172025.GE18525@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110222>

> Yikes.  Do we really need a public no-arg constructor for
> Externalizable?  If we do, maybe we should use Serializable instead
> so we can hide this constructor.  I don't like the idea of people
> creating ObjectId.zeroId() by new ObjectId().  That's not a pattern
> we should encourage.
>

Yes, you have to have a public no-args constructor for Externalizable.

 I agree, it's hideous. But I thought that was known as you explicitly
asked for Externalizable rather than Serializable with readObject /
writeObject... :-/

More than happy to re-roll with Serializable instead - do you want
this for all 4? (RemoteConfig also gained a no-args constructor
because of Externalizable..)

>> +     public void writeExternal(ObjectOutput out) throws IOException {
>> +             byte[] sha1 = new byte[20];
>> +             copyRawTo(sha1, 0);
>> +             out.write(sha1);
>> +     }
>
> Hmm.  I was thinking of just writing the 5 ints out, and reading
> the 5 ints back in.  We're always talking to another Java process.
> The ints are written in network byte order anyway on a serialization
> stream.  Doing this conversion to a byte[] thrases the caller's
> per-thread new generation rather hard.  I think applications using
> this type in a serialization stream would expect it to be quick.

I've taken the request for "the 20 byte SHA-1" too literally :-)

> +             Map<String, Collection<String>> map = new HashMap<String,
> Collection<String>>();
> +             for (int i = 0; i < items; i++) {
> +                     String key = in.readUTF();
> +                     String value = in.readUTF();
>Why not just serialize the Map in the stream?

Sure - if you're happy with that representation - it's not " a map of
keys/values as it appears in the config " though as it's a map to a
list because of the multi-values that are available for things like
URL and Fetch.
