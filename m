From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from the 
	git configuration
Date: Wed, 4 Feb 2009 09:14:55 +0100
Message-ID: <551f769b0902040014g380d4f00nd3dbbd6322fca434@mail.gmail.com>
References: <1233695594.8042.6.camel@localhost>
	 <20090203231357.GZ26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcvp-0001i0-Sw
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZBDIO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZBDIO7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:14:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:38503 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZBDIO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:14:58 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1137556fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hAB3lRQjQnsJuPo9JwFbOkMSHcuDXjE1cKdkSNlMGJc=;
        b=acxE+KPep6VH0OiaCeeNvV7lbOoD7UFlh8mLaXL+4mOnYSGJhOt++drM3Qzqb5pFFy
         cEs/nca8GbPyaRwMeEKyBIz/gkpXlqtjNTPZNIMy2jA5GxyF4Hlac09ACgs6yShDjrws
         /MtLjKP5xwyUO95JSkFOWOhkgbnYeUxMDqNH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J31VifShupnBdN5Pk/Ixc5jw0huKJWeQ2+UznTv/EnUuJvRRE2Y8toF3DJC4P/QQ2j
         gW68qeCIXLPo39iiNUuB4G0IJHCtMGRI+zbYlgJIUST+N7PdBKohxpM+Rz4ZHHU0UhlG
         ekdnkS8VWw8GXONtWqexy7QTF4+NiTqyn6wSM=
Received: by 10.181.235.6 with SMTP id m6mr958528bkr.190.1233735295902; Wed, 
	04 Feb 2009 00:14:55 -0800 (PST)
In-Reply-To: <20090203231357.GZ26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108309>

2009/2/4 Shawn O. Pearce <spearce@spearce.org>:
> Yann Simon <yann.simon.fr@gmail.com> wrote:
>> index 7df90cd..5821f83 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
>> @@ -50,6 +50,8 @@
>>  import java.io.InputStreamReader;
>>  import java.io.OutputStreamWriter;
>>  import java.io.PrintWriter;
>> +import java.net.InetAddress;
>> +import java.net.UnknownHostException;
>>  import java.util.ArrayList;
>>  import java.util.Collections;
>>  import java.util.HashMap;
>> @@ -98,6 +100,8 @@ public static RepositoryConfig openUserConfig() {
>>
>>       private Map<String, Object> byName;
>>
>> +     private String hostname;
>> +
>>       private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
>>
>>       RepositoryConfig(final Repository repo) {
>> @@ -308,6 +312,83 @@ public String getString(final String section, String subsection, final String na
>>               return result;
>>       }
>>
>> +     /**
>> +      * @return the author name as defined in the git variables
>> +      *         and configurations. If no name could be found, try
>> +      *         to use the system user name instead.
>> +      */
>> +     public String getAuthorName() {
>> +             return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
>> +     }
>> +
>> +     /**
>> +      * @return the commiter name as defined in the git variables
>> +      *         and configurations. If no name could be found, try
>> +      *         to use the system user name instead.
>> +      */
>> +     public String getCommiterName() {
>> +             return getUsernameInternal(Constants.GIT_COMMITER_NAME_KEY);
>> +     }
>> +
>> +     private String getUsernameInternal(String gitVariableKey) {
>> +             // try to get the user name from the local and global configurations.
>> +             String username = getString("user", null, "name");
>> +
>> +             if (username == null) {
>> +                     // try to get the user name for the system property GIT_XXX_NAME
>> +                     username = System.getProperty(gitVariableKey);
>
> Shouldn't that be System.getenv()?
>
>> +     private String getUserEmailInternal(String gitVariableKey, boolean author) {
>> +             // try to get the email from the local and global configs.
>> +             String email = getString("user", null, "email");
>> +
>> +             if (email == null) {
>> +                     // try to get the email for the system property GIT_XXX_EMAIL
>> +                     email = System.getProperty(gitVariableKey);
>
> Again, System.getenv()?
>
>> +     public String getHostname() {
>> +             if (hostname == null) {
>> +                     InetAddress localMachine;
>> +                     try {
>> +                             localMachine = InetAddress.getLocalHost();
>> +                             hostname = localMachine.getHostName();
>> +                     } catch (UnknownHostException e) {
>> +                             // we do nothing
>> +                     }
>> +             }
>> +             return hostname;
>
> Do we want getHostName() or getCanonicalHostName() here?
>
> I think we'd want getCanonicalHostName().

Yes, indeed. I change this.

>
> Should we be caching this at the RepositoryConfig level, or at the
> whole JVM level (in a static).  If the application is long-running
> its likely to keep the same RepositoryConfig instance around for
> the life of that JVM, so we'd only make this request once.  Thus any
> change in hostname while the application is running would probably
> not take effect until after restart.  But any long running app is
> also likely to access more than one Repository, and thus more than
> one RepositoryConfig, so they should at least use consistent names,
> even if the underlying hostname has changed.
>
> IMHO, just cache it in a static on first demand.

OK, that make sense.
Should the call be thread-safe if it can be called from different instances?

Yann
