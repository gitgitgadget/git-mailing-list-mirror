From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from the 
	git configuration
Date: Wed, 4 Feb 2009 09:42:09 +0100
Message-ID: <551f769b0902040042j23238581ia248c949ee395ff7@mail.gmail.com>
References: <1233695594.8042.6.camel@localhost>
	 <20090203231357.GZ26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdMA-0001VV-9G
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZBDImN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZBDImM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:42:12 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:63897 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZBDImL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:42:11 -0500
Received: by fxm13 with SMTP id 13so2894412fxm.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 00:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s7ODcDV+xOZFsv4XovE7RckoVAJ0WL4qBChercloOG0=;
        b=w8S121jIZs8B+uNRW7s9qwlob4XeH3jEGuFquYhUg1MFO1sGafwOEO3mF6zNWVkmDJ
         DPuCvRzw7R+mRxILtkhS1SO8uAirkJqtb4QqSfENCBsCl2ZPB/9RvyLHs6EvbrkXKsMG
         vendSSAfg1G1v2aPwhFWHweF1xA2KTsu+sUXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HOzVgyc9BU3X5RDo69xIQpWzxMxnkpMK2xa2dBXf64gnpSsaxokoBg7zdSTdkC68Zu
         TuJztkUgAbkuaifRP/ELOtG7D6BXZiIZmAyr7f5TW9caogU0uWy3YACMF+cZ6gqilyb5
         kuupyOsl/rj/BOv07wzP8gTX3fVflim0GSBmc=
Received: by 10.181.135.12 with SMTP id m12mr720026bkn.34.1233736929853; Wed, 
	04 Feb 2009 00:42:09 -0800 (PST)
In-Reply-To: <20090203231357.GZ26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108313>

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

Just a precision:
One of the consequences of using System.getenv() is that it does not
let java programs to define the value of the variable.
System.getProperty(), on the other hand, offers a System.setProperty()

If we use System.getenv(), we cannot overwrite the value before.

But we maybe do not need to overwrite system variables (except for
unit test... :) )

In that case, we can live with System.getenv().

A workaround would be to use a method like:
	private static String readEnvironmentVariable(String key) {
		String result = System.getProperty(key);
		if (result == null || result.length() == 0) {
			result = System.getenv(key);
		}
		return result;
	}

but I really dislike it. This is much more complex and make the
results less predictable.

I change my code to use System.getenv() unless you got other ideas.

Yann
