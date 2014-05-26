From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 1/2] config: Add cache for config value querying
Date: Mon, 26 May 2014 22:02:54 +0200
Message-ID: <53839DEE.9090504@web.de>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com> <1401125601-18249-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 22:03:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp172-0000XK-9I
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 22:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaEZUDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 16:03:07 -0400
Received: from mout.web.de ([212.227.15.14]:60018 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbaEZUDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 16:03:06 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MQedF-1XIWqZ1aiz-00U6bz; Mon, 26 May 2014 22:03:02
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401125601-18249-2-git-send-email-tanayabh@gmail.com>
X-Provags-ID: V03:K0:PRzZnlJbGNJ0YtS7TKXtdKXyJwlUKT8g7BfRXgaH7pKwTwwIZlI
 hlz5icNIoEmepGS2aBtCwuQz/BveRuYdHaAkGPpChgeC4gXU8EtLXziJxVw/caSZS6hAFbj
 cflQkm5dZTJ4j9JjILl34FAXOiS1YuBfvE+YKNAwn7T35W8n7EjnxygjPCLD8+ESY93AzwO
 ybOOudlgtpqtc5SVP3dbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250118>

On 2014-05-26 19.33, Tanay Abhra wrote:
I like the idea.
Please allow some minor comments (and read them as questions rather then answers)
> Add an internal cache with the all variable value pairs read from the usual
"cache": The word "cache" is in Git often used for "index" 
"variable value" can be written as "key value"
"usual": I don't think we handle "unusual" config files,
(so can we drop the word usual ?)
I think the (important) first line can be written like this:

>Add a hash table with the all key-value pairs read from the
or
>Add a hash table to cache all key-value pairs read from the

> config files(repo specific .git/config, user wide ~/.gitconfig and the global
> /etc/gitconfig). Also, add two external functions `git_config_get_string` and
Can we drop "Also" ?
> @@ -37,6 +39,102 @@ static struct config_source *cf;
>  
>  static int zlib_compression_seen;
>  
> +struct hashmap config_cache;
> +
> +struct config_cache_node {
> +	struct hashmap_entry ent;
> +	struct strbuf key;
Do we need a whole strbuf for the key?
Or could a "char *key" work as well? 
(and/or could it be "const char *key" ?
> +	struct string_list *value_list ;



> +static struct string_list *config_cache_get_value(const char *key)
> +{
> +	struct config_cache_node *e = config_cache_find_entry(key);
why "e" ? Will "node" be easier to read ? Or entry ? 


> +static void config_cache_set_value(const char *key, const char *value)
> +{
> +	struct config_cache_node *e;
> +
> +	if (!value)
> +		return;
Hm, either NULL could mean "unset==remove" the value, (but we don't do that, do we?

Or it could mean a programming or runtime error?, Should there be a warning ?

> +
> +	e = config_cache_find_entry(key);
> +	if (!e) {
> +		e = malloc(sizeof(*e));
> +		hashmap_entry_init(e, strihash(key));
> +		strbuf_init(&(e->key), 1024);
> +		strbuf_addstr(&(e->key),key);
> +		e->value_list = malloc(sizeof(struct string_list));
> +		e->value_list->strdup_strings = 1;
> +		e->value_list->nr = 0;
> +		e->value_list->alloc = 0;
> +		e->value_list->items = NULL;
> +		e->value_list->cmp = NULL;
When malloc() is replaced by xcalloc()  the x = NULL and y = 0 can go away,
and the code is shorter and easier to read.


> +extern const char *git_config_get_string(const char *name)
> +{
> +	struct string_list *values;
> +	int num_values;
> +	char *result;
> +	values = config_cache_get_value(name);
> +	if (!values)
> +		return NULL;
> +	num_values = values->nr;
> +	result = values->items[num_values-1].string ;
We could get rid of the variable  "int num_values" by simply writing
result = values->items[values->nr-1].string;
